import json
import requests

from fastapi import Depends, FastAPI, Request, Response, status
from fastapi.security import HTTPBearer
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.exceptions import HTTPException

import firebase_admin
from firebase_admin import credentials, auth

import backend.users as users
import backend.connect as connect
from backend.categories import categoryrouter
from backend.products import productrouter
from backend.lab_tests import testrouter
from backend.product_orders import productorderrouter
from backend.appointments import appointmentsrouter
from backend.supply_order import supplyorderrouter
# from backend.deadline import deadlinerouter

# Load the credentials from the .json file for accessing the MySQL database
connect.load_creds()
# Load the credentials from the .json file for accessing the Firebase
connect.connect_to_firebase()

app = FastAPI()
app.include_router(categoryrouter)
app.include_router(productrouter)
app.include_router(testrouter)
app.include_router(productorderrouter)
app.include_router(appointmentsrouter)
app.include_router(supplyorderrouter)
# app.include_router(deadlinerouter)

allow_all = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_all,
    allow_credentials=True,
    allow_methods=allow_all,
    allow_headers=allow_all,
) 

token_auth_scheme = HTTPBearer()

@app.get("/api/public")
def public():
    res = {
        "status": "success",
        "msg" : "You have reached a public endpoint, the server is up and running"
    }
    return res

@app.post("/api/signup")
async def signup(request: Request):
    req = await request.json()
    name = req.get("name")
    email:str = req.get("email")
    phone:str = req.get("phone")
    password:str = req.get("password")
    lat:float = req.get("lat")
    lon:float = req.get("lon")
    role:str = req.get("role")
    userid:str = None
    if email is None or password is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Email or password is missing"})
    try:
        if(role == 'customer'):
            userid = users.add_user_customer(name, email, phone, lat, lon)
        elif(role == 'retailer'):
            manager = req.get("manager")
            userid = users.add_user_retailer(name, email, phone, lat, lon, manager)
        elif(role == 'supplier'):
            userid = users.add_user_supplier(name, email, phone, lat, lon)
        elif(role == 'brand'):
            userid = users.add_user_brands(name, email, phone, lat, lon)
        elif(role == 'medical_lab'):
            userid = users.add_user_medical_lab(name, email, phone, lat, lon)
        else:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid role"})
        if userid is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Error while creating user"})
        print(userid)
        user = auth.create_user(uid = userid, email=email, password=password, display_name=name)
        users.add_role_to_firestore(userid, role)
        return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "User created successfully", "user_id" : user.uid, "expiresIn": user.tokens_valid_after_timestamp})
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": str(e)})

@app.post("/api/login")
async def login(request: Request):
    req = await request.json()
    email = req.get("email")
    password = req.get("password")
    if email is None or password is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Email or password is missing"})
    try:
        FIREBASE_WEB_API_KEY = json.load(open("firebase_credentials.json")).get("FIREBASE_WEB_API_KEY")
        payload = json.dumps({
            "email": email,
            "password": password,
            "returnSecureToken": "true"
        })
        response = requests.post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword",
                                params = {"key" : FIREBASE_WEB_API_KEY},
                                data=payload,)   
        if response.json().get("error") is not None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": response.json().get("error").get("message")})
        return JSONResponse(status_code=status.HTTP_200_OK, 
                            content={"status": "success", "msg": "User logged in successfully", 
                                    "token": response.json().get("idToken"), 
                                    "refreshToken": response.json().get("refreshToken"), 
                                    "expiresIn": response.json().get("expiresIn")})
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": str(e)})

@app.post("/api/logout")
async def logout(creds: str = Depends(token_auth_scheme)):
    req = await request.json()
    token = creds.credentials
    if token is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Token is missing"})
    try:
        user = auth.verify_id_token(token)
        auth.revoke_refresh_tokens(user.get("user_id"))
        return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "User logged out successfully"})
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": str(e)})

@app.get("/api/private")
def private(response: Response, token: str = Depends(token_auth_scheme)):
    """Check the passed jwt token and return the user id"""
    jwt_token = token.credentials
    userid = users.get_uid_using_token(jwt_token)
    if userid is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid token"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "User logged in successfully", "ID": users.get_uid_using_token(jwt_token)})