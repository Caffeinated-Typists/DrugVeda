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

supplyorderrouter = APIRouter(prefix="/api/supplyorder")

@supplyorderrouter.post("/create")
async def create_supply_order(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    uid = get_uid_using_token(user_token)
    role = get_role_from_firestore(uid)
    if role != "retailer":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    req = await request.json()
    cart = req.get("cart")
    total_price = req.get("total_price")
    order_id = uuid.uuid1().hex
    try:
        db = mysql.connect(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION")
        cursor.execute("""
            INSERT INTO supply_orders (OrderID, OrderDate, Amount, Status) values ("{}","{}","{}", "Placed")
        """.format(order_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), total_price))
        for item in cart:
            if item.get('pid') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Product ID not provided"})
            if item.get('quantity') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Quantity not provided"})
            if item.get('supplierid') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Supplier ID not provided"})
            batch_id = uuid.uuid1().hex
            cursor.execute("""
                INSERT INTO order_batches (OrderID, BatchID) values ("{}","{}")
            """.format(order_id, batch_id))
            cursor.execute("""
                INSERT INTO batches (BatchID, ProductID, Quantity, RetailerID, SupplierID) values ("{}","{}","{}","{}","{}")
            """.format(batch_id, item.get('pid'), item.get('quantity'), uid, item.get('supplierid')))
        cursor.execute("COMMIT")
    except Exception as e:
        cursor.execute("ROLLBACK")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": str(e)})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"msg": "Order placed successfully", "order_id": order_id})

@supplyorderrouter.get("/view_pending/{supplier_id}")
async def view_pending(supplier_id: str, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    uid = get_uid_using_token(user_token)
    if uid != supplier_id:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    role = get_role_from_firestore(uid)
    if role != "supplier":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    try:
        db = mysql.connect(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("""
            SELECT ProductID, Quantity, RetailerID FROM batches WHERE SupplierID = "{}"
        """.format(supplier_id))
        rem_orders = [{"pid": item[0], "quantity": item[1], "retailer_id": item[2]} for item in cursor.fetchall()]
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": str(e)})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"msg": "Pending orders fetched successfully", "orders": rem_orders})

@supplyorderrouter.post("/complete")
async def complete_supply_order(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    uid = get_uid_using_token(user_token)
    if uid is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    role = get_role_from_firestore(uid)
    if role != "supplier":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    req = await request.json()
    order_id = req.get("order_id")
    try:
        cursor.execute("START TRANSACTION")
        cursor.execute("""
            SELECT BatchID FROM order_batches WHERE OrderID = "{}"
        """.format(order_id))
        batch_ids = [item[0] for item in cursor.fetchall()]
        for batch_id in batch_ids:
            cursor.execute("""
                UPDATE batches SET ManufactureDate = "{}" WHERE BatchID = "{}"
            """.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"), batch_id))
        cursor.execute("COMMIT")
    except Exception as e:
        cursor.execute("ROLLBACK")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": str(e)})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"msg": "Order completed successfully"})