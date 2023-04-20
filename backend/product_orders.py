import os
from fastapi import APIRouter
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities
from backend.connect import connect_to_db

productorderrouter = APIRouter()

@productorderrouter.post("/api/productorder")
async def create_product_order(product_order: entities.ProductOrder):
    """Create a product order in the database"""
    req = await request.json()
    user_token = req.get("user_token")
    # Verify the user token

