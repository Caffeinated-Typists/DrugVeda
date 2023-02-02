from fastapi import Depends, FastAPI
from fastapi.security import HTTPBearer

app = FastAPI()

token_auth_scheme = HTTPBearer()

@app.get("/api/public")
def public():
    res = {
        "status": "success",
        "msg" : "You have reached a public endpoint, the server is up and running"
    }
    return res

@app.get("/api/private")
def private(token:str = Depends(token_auth_scheme)):
    
    result = token.credentials
    return result