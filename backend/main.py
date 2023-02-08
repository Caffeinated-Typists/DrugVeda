from fastapi import Depends, FastAPI, Response, status
from fastapi.security import HTTPBearer
from backend.utils import VerifyToken

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
def private(response: Response, token: str = Depends(token_auth_scheme)):
    """A valid access token is required to access this route"""
 
    result = VerifyToken(token.credentials).verify()

    if result.get("status"):
       response.status_code = status.HTTP_400_BAD_REQUEST
       return result
 
    return result