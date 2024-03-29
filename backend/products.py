import os
from fastapi import APIRouter, Request, Depends, Response, status
from fastapi.security import HTTPBearer
from fastapi.responses import JSONResponse
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities
import mysql.connector as mysql
from backend.connect import connect_to_db
import backend.users as users

token_auth_scheme = HTTPBearer()

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
        
@productrouter.post("/create")
async def create_product(request:Request, token:str = Depends(token_auth_scheme)):
    """Create a product in the database"""
    user_token:str = token.credentials
    if user_token is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Token is missing"})
    brand_id:str = users.get_uid_using_token(user_token)
    if brand_id is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Invalid token"})
    role:str = user.get_role_from_firestore(brand_id)
    if role != "brand":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "You are not authorized to perform this action"})
    req = await request.json()
    name:str = req.get("name")
    image:str = req.get("image")
    description:str = req.get("description")
    price:int = req.get("price")
    timetoexpire = req.get("timetoexpire")
    if name is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Name is missing"})
    if image is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Image is missing"})
    if description is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Description is missing"})
    if price is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Price is missing"})
    engine:sqlalchemy.engine.base.Engine = connect_to_db()
    with orm.Session(engine) as session:
        product = entities.Products(Name=name, Image=image, Description=description, Price=price, BrandID=brand_id, Rating=0, RatingCnt=0)
        session.add(product)
        session.commit()
        session.refresh(product)
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product created successfully", "data": {"id": product.ProductID}})

@productrouter.post("/delete")
async def delete_product(request:Request, token:str = Depends(token_auth_scheme)):
    user_token:str = token.credentials
    if user_token is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Token is missing"})
    brand_id:str = users.get_uid_using_token(user_token)
    if brand_id is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Invalid token"})
    role:str = users.get_role_from_firestore(brand_id)
    if role != "brand":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "You are not authorized to perform this action"})
    req = await request.json()
    product_id:str = req.get("product_id")
    if product_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product id is missing"})
    try:
        db = mysql.connec(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION;")
        cursor.execute("DELETE FROM Products WHERE ProductID = '{}'';".format(product_id))
        cursor.execute("COMMIT;")
        cursor.close()
        db.close()
    except Exception as e:  
        return JSONResponse(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, content={"status": "error", "msg": "Error while deleting product"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product deleted successfully"})