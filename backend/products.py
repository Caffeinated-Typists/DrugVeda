import os
from fastapi import APIRouter
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities
from backend.connect import connect_to_db

productrouter = APIRouter(prefix="/api/products")

@productrouter.get("/{product_id}")
async def get_product(product_id:str):
    """Return the details of the product with the given id"""
    check:bool = True
    product:entities.Products = None
    engine:sqlalchemy.engine.base.Engine = connect_to_db()
    with orm.Session(engine) as session:
        product = session.query(entities.Products).filter(entities.Products.ProductID == product_id).first()
        if product is None:
            check = False
        else:
            check = True
            product.BrandID = session.query(entities.Brand).filter(entities.Brand.BrandID == product.BrandID).first().Name
    if check:
        return {
            "status" : "success",
            "data" : {
                "id" : product.ProductID,
                "name" : product.Name,
                "image" : product.Image,
                "description" : product.Description,
                "price" : product.Price,
                "brand" : product.BrandID,
                "rating" : product.Rating,
                "rating_cnt" : product.RatingCnt
            }
        }
    else:
        return {
            "status" : "error",
            "message" : "Product not found"
        }
        
