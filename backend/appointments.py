import os
import requests
import uuid
from fastapi import APIRouter, Request, Depends
from fastapi.security import HTTPBearer
import mysql.connector as mysql
from backend.connect import connect_to_db
from backend.users import get_uid_using_token, get_role_from_firestore

token_auth_scheme = HTTPBearer()

appointmentsrouter = APIRouter(prefix="/api/appointments")

@appointmentsrouter.post("/create")
async def create_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    """Create an appointment in the database"""
    req = await request.json()
    user_token = token.credentials
    test_id = req.get("test_id")
    appointment_date = req.get("date")
    if user_token is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    if test_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Test ID is missing"})
    if appointment_date is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment date is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'customer':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can create appointments"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        cursor.execute("START TRANSACTION;")
        appointment_id = uuid.uuid1().hex
        cursor.execute("""
            insert into appointments (AppointmentID, TestID, CustomerID, BookingDate, AppointmentDate) 
            values ('{}', '{}', '{}', '{}', '{}');
        """.format(appointment_id, test_id, user_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), appointment_date))
        cursor.execute("COMMIT;")
    except Exception as e:
        appointment_id = None
        cursor.execute("ROLLBACK;")
    finally:
        db.close()
    if appointment_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment could not be created"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointment created successfully", "appointment_id": appointment_id})