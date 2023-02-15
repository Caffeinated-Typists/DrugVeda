import os
import typing
import sqlalchemy as sql
import sqlalchemy.orm as orm

def connect_to_db()->sql.engine.base.Engine:
    """Connect to the database and return the engine"""
    engine = sql.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine

def main()->None:
    """Main function of the script"""
    connect_to_db()

if __name__ == "__main__":
    main()
else:
    raise Exception("This file is not meant to be imported")