import sqlalchemy
meta = sqlalchemy.MetaData()

def connect()->sqlalchemy.create_engine:
    """Connects to the database"""
    engine = sqlalchemy.create_engine("mysql+mysqlconnector://root:root@localhost/DrugVeda", echo=True)
    return engine

def drop_tables(engine)->None:
    """Drops all the tables"""
    meta.drop_all(engine)

def create_tables(engine)->None:
    """Creates all the required tables"""

    customers = sqlalchemy.Table(
        "customers", meta,
        sqlalchemy.Column("CustomerID", sqlalchemy.String(36), primary_key=True, nullable=False),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Email", sqlalchemy.String(50), nullable=False, index=True),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
    )

    retailers = sqlalchemy.Table(
        "retailers", meta,
        sqlalchemy.Column("RetailerID", sqlalchemy.String(36), primary_key=True, nullable=False),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Email", sqlalchemy.String(50), nullable=False, index=True),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("Managaer", sqlalchemy.String(50), nullable=False),
    )

    suppliers = sqlalchemy.Table(
        "suppliers", meta,
        sqlalchemy.Column("SupplierID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Email", sqlalchemy.String(50), nullable=False, index=True),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
    )

    medical_labs = sqlalchemy.Table(
        "medical_labs", meta,
        sqlalchemy.Column("LabID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Email", sqlalchemy.String(50), nullable=False, index=True),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("Long", sqlalchemy.Float, nullable=False),
    )

    brands = sqlalchemy.Table(
        "brands", meta,
        sqlalchemy.Column("BrandID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Email", sqlalchemy.String(50), nullable=False, index=True),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
        sqlalchemy.Column("ProductCnt", sqlalchemy.Integer),
    )

    categories = sqlalchemy.Table(
        "categories", meta,
        sqlalchemy.Column("CategoryID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
    )

    subcategories = sqlalchemy.Table(
        "subcategories", meta,
        sqlalchemy.Column("SubcategoryID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
    )

    products = sqlalchemy.Table(
        "products", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
        sqlalchemy.Column("Description", sqlalchemy.String(100)),
        sqlalchemy.Column("Price", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("BrandID", sqlalchemy.String(36), sqlalchemy.ForeignKey("brands.BrandID"), nullable=False),
        sqlalchemy.Column("Rating", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("RatingCnt", sqlalchemy.Integer, nullable=False),
        sqlalchemy.Column("TimeToExpire", sqlalchemy.Integer),
    )

    product_categories = sqlalchemy.Table(
        "product_categories", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(36), sqlalchemy.ForeignKey("products.ProductID"), nullable=False, index=True),
        sqlalchemy.Column("CategoryID", sqlalchemy.String(36), sqlalchemy.ForeignKey("categories.CategoryID"), nullable=False, index=True),
        sqlalchemy.Column("SubcategoryID", sqlalchemy.String(36), sqlalchemy.ForeignKey("subcategories.SubcategoryID"), nullable=False, index=True),
    )

    # NEW TABLE
    product_suppliers = sqlalchemy.Table(
        "product_suppliers", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(36), sqlalchemy.ForeignKey("products.ProductID"), nullable=False, index=True),
        sqlalchemy.Column("SupplierID", sqlalchemy.String(36), sqlalchemy.ForeignKey("suppliers.SupplierID"), nullable=False, index=True),
    )

    supply_orders = sqlalchemy.Table(
        "supply_orders", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("BatchID", sqlalchemy.String(36), sqlalchemy.ForeignKey("batches.BatchID"), nullable=False, index=True),
        sqlalchemy.Column("OrderDate", sqlalchemy.DateTime, nullable=False),
        sqlalchemy.Column("Amount", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("Status", sqlalchemy.String(20)),
    )

    batches = sqlalchemy.Table(
        "batches", meta,
        sqlalchemy.Column("BatchID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("ProductID", sqlalchemy.String(36), sqlalchemy.ForeignKey("products.ProductID"), nullable=False, index=True),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer),
        sqlalchemy.Column("OrderID", sqlalchemy.String(36), sqlalchemy.ForeignKey("supply_orders.OrderID"), nullable=False, index=True),
        sqlalchemy.Column("ManufactureDate", sqlalchemy.DateTime, nullable=False),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("retailers.RetailerID"), nullable=False, index=True),
        sqlalchemy.Column("SupplierID", sqlalchemy.String(36), sqlalchemy.ForeignKey("suppliers.SupplierID"), nullable=False, index=True),
    )

    inventory = sqlalchemy.Table(
        "inventory", meta,
        sqlalchemy.Column("BatchID", sqlalchemy.String(36), sqlalchemy.ForeignKey("batches.BatchID"), nullable=False, index=True),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("retailers.RetailerID"), nullable=False, index=True),
        sqlalchemy.Column("QuantityRemaining", sqlalchemy.Integer, nullable=False),
    )

    product_orders = sqlalchemy.Table(
        "product_orders", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("customers.CustomerID"), nullable=False, index=True),
        sqlalchemy.Column("OrderDate", sqlalchemy.DateTime, nullable=False),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer, nullable=False),
        sqlalchemy.Column("Amount", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("Status", sqlalchemy.String(20)),
        sqlalchemy.Column("DeliveryMethod", sqlalchemy.String(50)),
        sqlalchemy.Column("PaymentMethod", sqlalchemy.String(50)),
    )

    # Dropped Composite Primary Key
    product_order_items = sqlalchemy.Table(
        "product_order_items", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(36), sqlalchemy.ForeignKey("product_orders.OrderID"), nullable=False, index=True),
        sqlalchemy.Column("ProductID", sqlalchemy.String(36), sqlalchemy.ForeignKey("products.ProductID"), nullable=False, index=True),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("customers.CustomerID"), nullable=False, index=True),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("retailers.RetailerID"), nullable=False, index=True),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer, nullable=False),
        sqlalchemy.Column("Amount", sqlalchemy.Float, nullable=False),
    )

    tests = sqlalchemy.Table(
        "tests", meta,
        sqlalchemy.Column("TestID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50), nullable=False),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
        sqlalchemy.Column("Description", sqlalchemy.String(100)),
        sqlalchemy.Column("Price", sqlalchemy.Float, nullable=False),
        sqlalchemy.Column("LabID", sqlalchemy.String(36), sqlalchemy.ForeignKey("medical_labs.LabID"), nullable=False, index=True),
    )

    appointments = sqlalchemy.Table(
        "appointments", meta,
        sqlalchemy.Column("AppointmentID", sqlalchemy.String(36), primary_key=True),
        sqlalchemy.Column("TestID", sqlalchemy.String(36), sqlalchemy.ForeignKey("tests.TestID"), nullable=False, index=True),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(36), sqlalchemy.ForeignKey("customers.CustomerID"), nullable=False, index=True),
        sqlalchemy.Column("BookingDate", sqlalchemy.DateTime, nullable=False),
        sqlalchemy.Column("AppointmentDate", sqlalchemy.DateTime, nullable=False),
        sqlalchemy.Column("Result", sqlalchemy.String(50)),
    )

    meta.create_all(engine)

def main()->None:
    """Main function"""
    engine = connect()
    drop_tables(engine)
    create_tables(engine)

if __name__ == "__main__":
    main()
else:
    raise Exception("This file is not meant to be imported")