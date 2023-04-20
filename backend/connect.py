import os
import json
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities

import firebase_admin
from firebase_admin import credentials, auth

def load_creds()->None:
    """Loads the credentials from the .json file, if they are not already loaded"""
    if "MySQL_USER" not in os.environ:
        with open("credentials.json", "r") as f:
            creds = json.load(f)
            os.environ["MySQL_USER"] = creds["user"]
            os.environ["MySQL_PASSWORD"] = creds["pwd"]
            os.environ["MySQL_DB_LINK"] = creds["db_url"]

def connect_to_db()->sqlalchemy.engine.base.Engine:
    """Connect to the database and return the engine"""
    engine = sqlalchemy.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine

def connect_to_firebase()->None:
    """Connect to the firebase"""
    cred = credentials.Certificate("drugveda_service_account_keys.json")
    firebase = firebase_admin.initialize_app(cred)
    # pb = pyrebase.initialize_app(json.load(open("firebase_config.json")))