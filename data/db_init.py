import os
import sys
import typing
import sqlalchemy as sql
import sqlalchemy.orm as orm

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))) # Add the parent directory to the path

from entities import * # Import all the entities

metadata = sql.MetaData() # Create the metadata object

def connect_to_db()->sql.engine.base.Engine:
    """Connect to the database and return the engine"""
    engine = sql.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine

def main()->None:
    """Main function of the script"""
    engine:sql.engine = connect_to_db()
    Base.metadata.create_all(engine) # Create all the tables

if __name__ == "__main__":
    main()
else:
    raise Exception("This file is not meant to be imported")