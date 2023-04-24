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

retailerrouter = APIRouter(prefix="/api/retailer")

@retailerrouter.post("/complete")
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
