import os
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities

def connect_to_db()->sqlalchemy.engine.base.Engine:
    """Connect to the database and return the engine"""
    engine = sqlalchemy.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine

def get_all_categories(engine:sqlalchemy.engine)->list[str]:
    """Returns name of all categories from the database"""
    with orm.Session(engine) as session:
        categories = session.query(entities.Category).all()
        return [category.Name for category in categories]