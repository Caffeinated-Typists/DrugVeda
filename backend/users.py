import mysql.connector as mysql
import uuid

def add_user_customer(name:str, email:str, phone:str, lat:float, lon:float):
    """Add a new customer to the database"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        CustID = uuid.uuid1().hex
        cursor.execute("""insert into customers (CustomerID, Name, Email, Phone, Lat, Lon) values ('{}', '{}', '{}', '{}', {}, {});"""
        .format(CustID, name, email, phone, lat, lon))
        db.commit()
    except Exception as e:
        CustID = None
        db.rollback()
    finally:
        db.close()
    return CustID

def add_user_retailer(name:str, email:str, phone:str, lat:float, lon:float, manager:str):
    """Add a new retailer to the database"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        RetailID = uuid.uuid1().hex
        cursor.execute("""insert into retailers (RetailerID, Name, Email, Phone, Lat, Lon, Manager) values ('{}', '{}', '{}', '{}', {}, {}, '{}');"""
        .format(RetailID, name, email, phone, lat, lon, manager))
        db.commit()
    except Exception as e:
        RetailID = None
        db.rollback()
    finally:
        db.close()
    return RetailID

def add_user_supplier(name:str, email:str, phone:str, lat:float, lon:float):
    """Add a new supplier to the database"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        SuppID = uuid.uuid1().hex
        cursor.execute("""insert into suppliers (SupplierID, Name, Email, Phone, Lat, Lon) values ('{}', '{}', '{}', '{}', {}, {});"""
        .format(SuppID, name, email, phone, lat, lon))
        db.commit()
    except Exception as e:
        SuppID = None
        db.rollback()
    finally:
        db.close()
    return SuppID

def add_user_brands(name:str, email:str, phone:str, lat:float, lon:float):
    """Add a new brand to the database"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        BrandID = uuid.uuid1().hex
        cursor.execute("""insert into brands (BrandID, Name, Email, Phone, Lat, Lon) values ('{}', '{}', '{}', '{}', {}, {});"""
        .format(BrandID, name, email, phone, lat, lon))
        db.commit()
    except Exception as e:
        BrandID = None
        db.rollback()
    finally:
        db.close()
    return BrandID

def add_user_medical_labs(name:str, email:str, phone:str, lat:float, lon:float):
    """Add a new medical lab to the database"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        LabID = uuid.uuid1().hex
        cursor.execute("""insert into medical_labs (LabID, Name, Email, Phone, Lat, Lon) values ('{}', '{}', '{}', '{}', {}, {});"""
        .format(LabID, name, email, phone, lat, lon))
        db.commit()
    except Exception as e:
        LabID = None
        db.rollback()
    finally:
        db.close()
    return LabID