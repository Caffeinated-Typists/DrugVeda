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
        sqlalchemy.Column("CustomerID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Email", sqlalchemy.String(50)),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
    )

    retailers = sqlalchemy.Table(
        "retailers", meta,
        sqlalchemy.Column("RetailerID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Email", sqlalchemy.String(50)),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
        sqlalchemy.Column("Managaer", sqlalchemy.String(50)),
    )

    suppliers = sqlalchemy.Table(
        "suppliers", meta,
        sqlalchemy.Column("SupplierID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Email", sqlalchemy.String(50)),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
    )

    medical_labs = sqlalchemy.Table(
        "medical_labs", meta,
        sqlalchemy.Column("LabID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Email", sqlalchemy.String(50)),
        sqlalchemy.Column("Phone", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
    )

    brands = sqlalchemy.Table(
        "brands", meta,
        sqlalchemy.Column("BrandID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Email", sqlalchemy.String(50)),
        sqlalchemy.Column("Lat", sqlalchemy.Float),
        sqlalchemy.Column("Long", sqlalchemy.Float),
        sqlalchemy.Column("ProductCnt", sqlalchemy.Integer),
    )

    categories = sqlalchemy.Table(
        "categories", meta,
        sqlalchemy.Column("CategoryID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
    )

    subcategories = sqlalchemy.Table(
        "subcategories", meta,
        sqlalchemy.Column("SubcategoryID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
    )

    products = sqlalchemy.Table(
        "products", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
        sqlalchemy.Column("Description", sqlalchemy.String(100)),
        sqlalchemy.Column("Price", sqlalchemy.Float),
        sqlalchemy.Column("BrandID", sqlalchemy.String(35), sqlalchemy.ForeignKey("brands.BrandID")),
        sqlalchemy.Column("Rating", sqlalchemy.Float),
        sqlalchemy.Column("RatingCnt", sqlalchemy.Integer),
        sqlalchemy.Column("TimeToExpire", sqlalchemy.Integer),
    )

    product_categories = sqlalchemy.Table(
        "product_categories", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(35), sqlalchemy.ForeignKey("products.ProductID")),
        sqlalchemy.Column("CategoryID", sqlalchemy.String(35), sqlalchemy.ForeignKey("categories.CategoryID")),
        sqlalchemy.Column("SubcategoryID", sqlalchemy.String(35), sqlalchemy.ForeignKey("subcategories.SubcategoryID")),
    )

    # NEW TABLE
    product_suppliers = sqlalchemy.Table(
        "product_suppliers", meta,
        sqlalchemy.Column("ProductID", sqlalchemy.String(35), sqlalchemy.ForeignKey("products.ProductID")),
        sqlalchemy.Column("SupplierID", sqlalchemy.String(35), sqlalchemy.ForeignKey("suppliers.SupplierID")),
    )

    supply_orders = sqlalchemy.Table(
        "supply_orders", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("BatchID", sqlalchemy.String(35), sqlalchemy.ForeignKey("batches.BatchID")),
        sqlalchemy.Column("OrderDate", sqlalchemy.DateTime),
        sqlalchemy.Column("Amount", sqlalchemy.Float),
        sqlalchemy.Column("Status", sqlalchemy.String(20)),
    )

    batches = sqlalchemy.Table(
        "batches", meta,
        sqlalchemy.Column("BatchID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("ProductID", sqlalchemy.String(35), sqlalchemy.ForeignKey("products.ProductID")),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer),
        sqlalchemy.Column("OrderID", sqlalchemy.String(35), sqlalchemy.ForeignKey("supply_orders.OrderID")),
        sqlalchemy.Column("ManufactureDate", sqlalchemy.DateTime),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("retailers.RetailerID")),
        sqlalchemy.Column("SupplierID", sqlalchemy.String(35), sqlalchemy.ForeignKey("suppliers.SupplierID")),
    )

    inventory = sqlalchemy.Table(
        "inventory", meta,
        sqlalchemy.Column("BatchID", sqlalchemy.String(35), sqlalchemy.ForeignKey("batches.BatchID")),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("retailers.RetailerID")),
        sqlalchemy.Column("QuantityRemaining", sqlalchemy.Integer),
    )

    product_orders = sqlalchemy.Table(
        "product_orders", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("customers.CustomerID")),
        sqlalchemy.Column("OrderDate", sqlalchemy.DateTime),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer),
        sqlalchemy.Column("Amount", sqlalchemy.Float),
        sqlalchemy.Column("Status", sqlalchemy.String(20)),
        sqlalchemy.Column("DeliveryMethod", sqlalchemy.String(50)),
        sqlalchemy.Column("PaymentMethod", sqlalchemy.String(50)),
    )

    # Dropped Composite Primary Key
    product_order_items = sqlalchemy.Table(
        "product_order_items", meta,
        sqlalchemy.Column("OrderID", sqlalchemy.String(35), sqlalchemy.ForeignKey("product_orders.OrderID")),
        sqlalchemy.Column("ProductID", sqlalchemy.String(35), sqlalchemy.ForeignKey("products.ProductID")),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("customers.CustomerID")),
        sqlalchemy.Column("RetailerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("retailers.RetailerID")),
        sqlalchemy.Column("Quantity", sqlalchemy.Integer),
        sqlalchemy.Column("Amount", sqlalchemy.Float),
    )

    tests = sqlalchemy.Table(
        "tests", meta,
        sqlalchemy.Column("TestID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("Name", sqlalchemy.String(50)),
        sqlalchemy.Column("Image", sqlalchemy.String(50)),
        sqlalchemy.Column("Description", sqlalchemy.String(100)),
        sqlalchemy.Column("Price", sqlalchemy.Float),
        sqlalchemy.Column("LabID", sqlalchemy.String(35), sqlalchemy.ForeignKey("medical_labs.LabID")),
    )

    appointments = sqlalchemy.Table(
        "appointments", meta,
        sqlalchemy.Column("AppointmentID", sqlalchemy.String(35), primary_key=True),
        sqlalchemy.Column("TestID", sqlalchemy.String(35), sqlalchemy.ForeignKey("tests.TestID")),
        sqlalchemy.Column("CustomerID", sqlalchemy.String(35), sqlalchemy.ForeignKey("customers.CustomerID")),
        sqlalchemy.Column("BookingDate", sqlalchemy.DateTime),
        sqlalchemy.Column("AppointmentDate", sqlalchemy.DateTime),
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