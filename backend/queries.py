import os
import sqlalchemy
import sqlalchemy.orm as orm
import data.entities as entities

def load_creds()->None:
    """Loads the credentials from the .json fill, if they are not already loaded"""
    if "MySQL_USER" not in os.environ:
        import json
        with open("credentials.json", "r") as f:
            creds = json.load(f)
            os.environ["MySQL_USER"] = creds["user"]
            os.environ["MySQL_PASSWORD"] = creds["pwd"]
            os.environ["MySQL_DB_LINK"] = creds["db_url"]

def connect_to_db()->sqlalchemy.engine.base.Engine:
    """Connect to the database and return the engine"""
    load_creds()
    engine = sqlalchemy.create_engine(f"mysql+mysqlconnector://{os.environ['MySQL_USER']}:{os.environ['MySQL_PASSWORD']}@{os.environ['MySQL_DB_LINK']}", echo=True)
    return engine

def get_all_categories(engine:sqlalchemy.engine)->list[dict[str: str]]:
    """Returns name of all categories from the database"""
    with orm.Session(engine) as session:
        categories = session.query(entities.Category).all()
        return [[category.Name, category.CategoryID, category.Image] for category in categories]