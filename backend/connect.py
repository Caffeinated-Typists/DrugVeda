import os
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities

def load_creds()->None:
    """Loads the credentials from the .json file, if they are not already loaded"""
    if "MySQL_USER" not in os.environ:
        import json
        with open("credentials.json", "r") as f:
            creds = json.load(f)
            os.environ["MySQL_USER"] = creds["user"]
            os.environ["MySQL_PASSWORD"] = creds["pwd"]
            os.environ["MySQL_DB_LINK"] = creds["db_url"]

def connect_to_db()->sqlalchemy.engine.base.Engine:
    """Connect to the database and return the engine"""
    engine = sqlalchemy.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine