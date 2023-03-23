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