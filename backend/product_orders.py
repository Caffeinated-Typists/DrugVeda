import os
from fastapi import APIRouter
import mysql.connector as mysql
import data.entities as entities
from backend.connect import connect_to_db
from users import get_role_using_token

productorderrouter = APIRouter()

@productorderrouter.post("/api/productorder")
async def create_product_order(product_order: entities.ProductOrder):
    """Create a product order in the database"""
    req = await request.json()
    user_token = req.get("user_token")
    if(user_token is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    role = get_role_using_token(user_token)
    if(role != 'customer'):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can create product orders"})
    
