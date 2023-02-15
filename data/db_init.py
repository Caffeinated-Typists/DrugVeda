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

def create_tables(engine:sql.engine)->None:
    """Create all the tables"""
    with orm.Session(engine) as session:
        Base.metadata.create_all(engine)
        session.commit()

def drop_tables(engine:sql.engine)->None:
    """Drop all the tables"""
    with orm.Session(engine) as session:
        Base.metadata.drop_all(engine)
        session.commit()

def clear_tables(engine:sql.engine)->None:
    """Clear all the tables"""
    with orm.Session(engine) as session:
        for table in reversed(Base.metadata.sorted_tables):
            session.execute(table.delete())
        session.commit()

def main()->None:
    """Main function of the script"""
    engine:sql.engine = connect_to_db()
    drop_tables(engine)
    create_tables(engine)

if __name__ == "__main__":
    main()
else:
    raise Exception("This file is not meant to be imported")