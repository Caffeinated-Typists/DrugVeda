import os
from fastapi import APIRouter
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities
from backend.connect import connect_to_db

testrouter = APIRouter(prefix="/api/test")

@testrouter.get("/")
async def get_all_tests():
    """Retuns the names of all tests from the database"""
    engine:sqlalchemy.engine.base.Engine = connect_to_db()
    with orm.Session(engine) as session:
        tests = session.query(entities.Test).all()
        labName:dict[str, str] = {}
        for test in tests:
            labName[test.TestID] = session.query(entities.MedicalLab).filter(entities.MedicalLab.LabID == test.LabID).first().Name
        data = [{"id" : test.TestID, "name" : test.Name, "desc" : test.Description, "price" : test.Price, "lab" : labName[test.TestID]} for test in tests]

    return {
        "status" : "success",
        "data" : data
    }