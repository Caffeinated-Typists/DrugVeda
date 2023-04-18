import json

from fastapi import Depends, FastAPI, Request, Response, status
from fastapi.security import HTTPBearer
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.exceptions import HTTPException

import firebase_admin
import pyrebase
from firebase_admin import credentials, auth

from backend.utils import VerifyToken
import backend.connect as connect
from backend.categories import categoryrouter
# from backend.deadline import deadlinerouter
from backend.products import productrouter

# Load the credentials from the .json file for accessing the MySQL database
connect.load_creds()

app = FastAPI()
app.include_router(categoryrouter)
app.include_router(productrouter)
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

# @app.post("/signup", include_in_schema=False)
# async def signup()

@app.get("/api/private")
def private(response: Response, token: str = Depends(token_auth_scheme)):
    """A valid access token is required to access this route"""
 
    result = VerifyToken(token.credentials).verify()

    if result.get("status"):
       response.status_code = status.HTTP_400_BAD_REQUEST
       return result
 
    return result