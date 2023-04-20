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
from backend.utils import VerifyToken
import backend.connect as connect
from backend.categories import categoryrouter
from backend.products import productrouter
from backend.lab_tests import testrouter
# from backend.deadline import deadlinerouter

# Load the credentials from the .json file for accessing the MySQL database
connect.load_creds()
# Load the credentials from the .json file for accessing the Firebase
connect.connect_to_firebase()

app = FastAPI()
app.include_router(categoryrouter)
app.include_router(productrouter)
app.include_router(testrouter)
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

@app.post("/signup")
async def signup(request: Request):
    req = await request.json()
    name = req.get("name")
    email:str = req.get("email")
    phone:str = req.get("phone")
    password:str = req.get("password")
    lat = req.get("lat")
    lon = req.get("lon")
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
        user = auth.create_user(uid = userid, email=email, password=password, display_name=name, phone_number=phone)
        user.add_role_to_firestore(userid, role)
        return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "User created successfully"})
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": str(e)})

@app.post("/login")
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
        return JSONResponse(status_code=status.HTTP_200_OK, 
                            content={"status": "success", "msg": "User logged in successfully", 
                                    "token": response.json().get("idToken"), 
                                    "refreshToken": response.json().get("refreshToken"), 
                                    "expiresIn": response.json().get("expiresIn")})
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": str(e)})

@app.post("/logout")
async def logout(request: Request):
    req = await request.json()
    token = req.get("token")
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
    """A valid access token is required to access this route"""
 
    result = VerifyToken(token.credentials).verify()

    if result.get("status"):
       response.status_code = status.HTTP_400_BAD_REQUEST
       return result
 
    return result