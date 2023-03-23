import os
from fastapi import APIRouter
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities
from backend.connect import connect_to_db

categoryrouter = APIRouter(prefix="/api/categories")

@categoryrouter.get("/")
def get_all_categories():
    """Returns name of all categories from the database"""
    engine:sqlalchemy.engine.base.Engine = connect_to_db()
    with orm.Session(engine) as session:
        categories = session.query(entities.Category).all()
        data = [{"id" : category.CategoryID ,"name" : category.Name, "image" : category.Image} for category in categories]
    return {
        "status" : "success",
        "data" : data
    }

@categoryrouter.get("/{category_id}")
def get_category(category_id:str):
    engine:sqlalchemy.engine.base.Engine = connect_to_db()
    with orm.Session(engine) as session:
        check = False
        if session.query(entities.Category).filter(entities.Category.CategoryID == category_id).first() is None:
            check = True
    if check:
        return {
            "status" : "error",
            "message" : "Category not found"
        }
    with orm.Session(engine) as session:
        subcategories = session.query(entities.ProductCategory).filter(entities.ProductCategory.CategoryID == category_id).all()
        subcategories:set[str] = set([subcategory.SubCategoryID for subcategory in subcategories])
        brand_name:dict[str:str] = {}
        for brand in session.query(entities.Brand).all():
            brand_name[brand.BrandID] = brand.Name
        data:list[dict] = []
        brands:set[str] = set()
        min_price:int = int(1e9)
        max_price:int = 0
        for subcategory in subcategories:
            subcategory_obj = session.query(entities.SubCategory).filter(entities.SubCategory.SubcategoryID == subcategory).first()
            products = session.query(entities.ProductCategory).filter(entities.ProductCategory.SubCategoryID == subcategory, entities.ProductCategory.CategoryID == category_id).all()
            products = session.query(entities.Products).filter(entities.Products.ProductID.in_([product.ProductID for product in products])).all()
            brands.update([brand_name[product.BrandID] for product in products])
            min_price = min(min_price, min([product.Price for product in products]))
            max_price = max(max_price, max([product.Price for product in products]))
            products = [{"id" : product.ProductID, "name" : product.Name, "image" : product.Image, "price" : product.Price, "brand" : brand_name[product.BrandID]} for product in products]
            data.append({"id" : subcategory_obj.SubcategoryID, "name" : subcategory_obj.Name, "products" : products})
    return {
        "status" : "success",
        "products" : data,
        "brands" : brands,
        "min_price" : min_price,
        "max_price" : max_price
    }