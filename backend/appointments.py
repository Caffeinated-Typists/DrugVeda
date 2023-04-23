import os
import requests
import uuid
from datetime import datetime
from fastapi import APIRouter, Request, Depends, Response, status
from fastapi.security import HTTPBearer
from fastapi.responses import JSONResponse
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

@appointmentsrouter.get("/view")
async def get_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    """Get all the appointments of a Medical Lab"""
    user_token = token.credentials
    lab_id:str = users.get_uid_using_token(user_token)
    if lab_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role:str = users.get_role_from_firestore(lab_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'medical_lab':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs can get appointments"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select tests.TestID, customers.CustomerID, appointments.AppointmentDate
        from appointments
        right join tests on tests.TestID = appointments.TestID
        right join medical_labs on medical_labs.LabID = tests.LabID
        right join customers on customers.CustomerID = appointments.CustomerID
        where medical_labs.LabID = '{}'
        order by appointments.AppointmentDate;
    """.format(lab_id))
    appointments = cursor.fetchall()
    cursor.execute("COMMIT;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointments fetched successfully", "appointments": [{"test_id" : appointment[0], "customer_id" : appointment[1], "appointment_date" : appointment[2]} for appointment in appointments]})

@appointmentsrouter.post("/complete")
async def complete_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    user_id = users.get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = users.get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'medical_lab':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs can complete appointments"})
    req = await request.json()
    appointment_id = req.get("appointment_id")
    if appointment_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment ID is missing"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    check:Bool = False
    try:
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select tests.LabID from appointments, tests 
            where tests.TestID = appointments.TestID and appointments.AppointmentID = '{}';
            """.format(appointment_id))
        lab_id = cursor.fetchone()[0]
        if lab_id != user_id:
            cursor.execute("COMMIT;")
            db.close()
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment does not belong to this lab"})
        cursor.execute("""
            update appointments set AppointmentStatus = 'completed' where AppointmentID = '{}';
            """.format(appointment_id))
        cursor.execute("COMMIT;")
        check = True
    except Exception as e:
        cursor.execute("ROLLBACK;")
        check = False
    finally:
        db.close()
    if not check:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment could not be completed"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointment completed successfully"})

@appointmentsrouter.get("/get/{AppointmentID}")
async def get_appointment_details(request: Request, AppointmentID: str, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    user_id = users.get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = users.get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role == 'medical_lab' or role == 'customer':
        db = mysql.connect(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select * from appointments where AppointmentID = '{}';
            """.format(AppointmentID))
        appointment = cursor.fetchone()
        cursor.execute("COMMIT;")
        db.close()
        if appointment is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment not found"})
        return JSONResponse(status_code=status.HTTP_200_OK, content={
                "status": "success", 
                "msg": "Appointment fetched successfully", 
                "appointment": {"appointment_id" : appointment[0], "test_id" : appointment[1], "customer_id" : appointment[2], "booking_date" : appointment[3], "appointment_date" : appointment[4], "appointment_status" : appointment[5]}
            })
    else:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs and customers can get appointments"})
