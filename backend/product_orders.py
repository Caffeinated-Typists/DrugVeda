import os
import requests
import uuid
from datetime import datetime
from fastapi import APIRouter, Request, Depends, Response, status
from fastapi.security import HTTPBearer
from fastapi.responses import JSONResponse
import mysql.connector as mysql
from backend.connect import connect_to_db
from backend.users import get_uid_using_token, get_role_from_firestore

token_auth_scheme = HTTPBearer()

productorderrouter = APIRouter(prefix="/api/productorder")

@productorderrouter.post("/create")
async def create_product_order(request: Request, token: str = Depends(token_auth_scheme)):
    """Create a product order in the database"""
    req = await request.json()
    user_token = token.credentials
    cart = req.get("cart")
    delivery_method = req.get("delivery_method")
    payment_method = req.get("payment_method")
    subtotal = req.get("subtotal")
    if(user_token is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    if(cart is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Cart is missing"})
    if(delivery_method is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Delivery method is missing"})
    if(payment_method is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Payment method is missing"})
    if(subtotal is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Subtotal is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if(role != 'customer'):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can create product orders"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    possible = True
    buy_from:dict[str, str] = {}
    for item in cart:
        if item["pid"] is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product ID is missing"})
        if item["quantity"] is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Quantity is missing"})
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select inventory.RetailerID from inventory, batches 
            where inventory.BatchID = batches.BatchID and batches.ProductID = "{}" and inventory.QuantityRemaining > {};
        """.format(item["pid"], item["quantity"]))
        available_retailers = cursor.fetchall()
        if(len(available_retailers) == 0):
            possible = False
            cursor.execute("ROLLBACK;")
            buy_from[item["pid"]] = None
        else:
            buy_from[item["pid"]] = available_retailers[0][0]
        cursor.execute("ROLLBACK;")
    if not possible:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": f"Not enough stock for products {[item['pid'] for item in cart if buy_from[item['pid']] is None]}"})
    cursor.execute("START TRANSACTION;")
    orderid = uuid.uuid1().hex
    cursor.execute("""
        insert into product_orders (OrderID, CustomerID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod)
        values ("{}", "{}", "{}", {}, {}, "Placed", "{}", "{}");
    """.format(orderid, user_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), sum([item["quantity"] for item in cart]), subtotal, delivery_method, payment_method))
    for item in cart:
        cursor.execute("""select Price from products where ProductID = "{}";""".format(item["pid"]))
        item_price = cursor.fetchone()[0]
        cursor.execute("""
            insert into product_order_items (OrderID, CustomerID, ProductID, RetailerID, Quantity, Amount)
            values ("{}", "{}", "{}", "{}", {}, {});
        """.format(orderid, user_id, item["pid"], buy_from[item["pid"]], item["quantity"], item["quantity"]*item_price))
    cursor.execute("COMMIT;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product order created successfully", "orderid": orderid})

@productorderrouter.get("/get/customer/{orderid}")
async def get_product_order(orderid:str, token: str = Depends(token_auth_scheme)):
    """Returns the product order details for the given Order ID (Customer Endpoint)"""
    user_token = token.credentials
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select CustomerID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod from product_orders where OrderID = "{}";
    """.format(orderid))
    order = cursor.fetchone()
    if order is None:
        cursor.execute("ROLLBACK;")
        db.close()
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product order not found"})
    cursor.execute("""
        select ProductID, Quantity from product_order_items where OrderID = "{}";
    """.format(orderid))
    items = [{"pid" : i[0], "quantity" : i[1]} for i in cursor.fetchall()]
    cursor.execute("ROLLBACK;")
    db.close()
    if order[0] != get_uid_using_token(user_token):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Not Authorized to view this product order"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={
        "status": "success", 
        "msg": "Product order fetched successfully", 
        "orderid": orderid, 
        "orderdate": order[1], 
        "quantity": order[2], 
        "amount": order[3], 
        "status": order[4], 
        "deliverymethod": order[5], 
        "paymentmethod": order[6], 
        "items": items}
    )

@productorderrouter.get("/get/retailer/{orderid}")
async def get_product_order_retailer(orderid:str, token: str = Depends(token_auth_scheme)):
    """Returns the product order details for the given Order ID (Retailer Endpoint)"""
    user_token = token.credentials
    retailerid = get_uid_using_token(user_token)
    role = get_role_from_firestore(retailerid)
    if role != 'retailer':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only retailers can view product orders"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select ProductID, Quantity from product_order_items where OrderID = "{}" and RetailerID = "{}";
    """.format(orderid, retailerid))
    items = [{"pid" : i[0], "quantity" : i[1]} for i in cursor.fetchall()]
    cursor.execute("ROLLBACK;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status" : "success", "msg" : "Product order fetched successfully", "orderid" : orderid, "items" : items})

@productorderrouter.get("/get/history")
async def get_order_history(token: str = Depends(token_auth_scheme)):
    """Returns the product order history for the given Customer ID"""
    user_token = token.credentials
    customer_id = get_uid_using_token(user_token)
    role = get_role_from_firestore(customer_id)
    if role != 'customer':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can view product order history"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select OrderID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod from product_orders where CustomerID = "{}";
    """.format(customer_id))
    orders = [{"orderid": i[0], "orderdate": i[1], "quantity": i[2], "amount": i[3], "status": i[4], "deliverymethod": i[5], "paymentmethod": i[6]} for i in cursor.fetchall()]
    cursor.execute("ROLLBACK;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product order history fetched successfully", "orders": orders})

@productorderrouter.post("/complete")
async def complete_product_order(request: Request, token: str = Depends(token_auth_scheme)):
    """Complete a product order in the database"""
    user_token = token.credentials
    if(user_token is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if(role != 'retailer'):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only retailers can complete product orders"})
    req = await request.json()
    order_id = req.get("order_id")
    if(order_id is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Order ID is missing"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""SELECT ProductID, Quantity FROM product_order_items where OrderID = '{}' and RetailerID = '{}'""".format(order_id, user_id))
    order_items = [{"pid": x[0], "qty": x[1]} for x in cursor.fetchall()]
    if(len(order_items) == 0):
        cursor.execute("ROLLBACK;")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid order ID"})
    for order_item in order_items:
        cursor.execute("""SELECT QuantityRemaining from product_inventory_view where ProductID = '{}' and RetailerID = '{}'""".format(order_item["pid"], user_id))
        qty_remaining = cursor.fetchone()[0]
        if qty_remaining < order_item["qty"]:
            cursor.execute("ROLLBACK;")
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Insufficient quantity"})
    for order_item in order_items:
        cursor.execute("CALL sell_product('{}', '{}', '{}')".format(user_id, order_item["pid"], order_item["qty"]))
    cursor.execute("COMMIT;")
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Order completed successfully"})  