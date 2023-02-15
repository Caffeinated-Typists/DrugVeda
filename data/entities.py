import typing
import datetime
import enum
import sqlalchemy as sql
import sqlalchemy.orm as orm

class Status(enum.Enum):
    Placed = 'Placed'
    Shipped = 'Shipped'
    Delivered = 'Delivered'
    Cancelled = 'Cancelled'

class Payment(enum.Enum):
    Cash = 'Cash'
    Credit_Card = 'Credit Card'
    Debit_Card = 'Debit Card'
    Net_Banking = 'Net Banking'
    Paytm = 'Paytm'
    PhonePe = 'PhonePe'
    Google_Pay = 'Google Pay'
    Amazon_Pay = 'Amazon Pay'
    UPI = 'UPI'

class Delivery(enum.Enum):
    Delivery = 'Delivery'
    Pickup = 'Pickup'

class Base(orm.DeclarativeBase):
    pass

class Customer(Base):
    __tablename__ = "customers"

    CustomerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)

    sql.PrimaryKeyConstraint(CustomerID, name="pk_customers_customerid")

    def __repr__(self) -> str:
        return f"Customer(ID={self.CustomerID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"

class Retailer(Base):
    __tablename__ = "retailers"

    RetailerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Manager:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)

    sql.PrimaryKeyConstraint(RetailerID, name="pk_retailers_retailerid")

    def __repr__(self) -> str:
        return f"Retailer(ID={self.RetailerID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon}, Manager={self.Manager})"

class Supplier(Base):
    __tablename__ = "suppliers"

    SupplierID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)

    sql.PrimaryKeyConstraint(SupplierID, name="pk_suppliers_supplierid")

    def __repr__(self) -> str:
        return f"Supplier(ID={self.SupplierID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"

class Brand(Base):
    __tablename__ = "brands"

    BrandID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)
    ProductCnt:orm.Mapped[int] = orm.mapped_column(sql.Integer)

    sql.PrimaryKeyConstraint(BrandID, name="pk_brands_brandid")

    def __repr__(self) -> str:
        return f"Brand(ID={self.BrandID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon}, ProductCnt={self.ProductCnt})"

class MedicalLab(Base):
    __tablename__ = "medical_labs"

    LabID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)

    sql.PrimaryKeyConstraint(LabID, name="pk_medical_labs_labid")
    
    def __repr__(self) -> str:
        return f"Medical_Lab(ID={self.LabID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"

class Products(Base):
    __tablename__ = "products"

    ProductID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Image:orm.Mapped[str] = orm.mapped_column(sql.String(255))
    Description:orm.Mapped[str] = orm.mapped_column(sql.String(8191))
    Price:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)
    BrandID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Rating:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)
    RatingCnt:orm.Mapped[int] = orm.mapped_column(sql.Integer, nullable=False)
    TimeToExpire:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME)

    sql.PrimaryKeyConstraint(ProductID, name="pk_products_productid")
    sql.ForeignKeyConstraint([BrandID], [Brand.BrandID], name="fk_products_brandid")

    def __repr__(self) -> str:
        return f"Product(ID={self.ProductID}, Name={self.Name}, Image={self.Image}, Description={self.Description}, Price={self.Price}, BrandID={self.BrandID}, Rating={self.Rating}, RatingCnt={self.RatingCnt}, TimeToExpire={self.TimeToExpire})"

class Category(Base):
    __tablename__ = "categories"

    CategoryID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Image:orm.Mapped[str] = orm.mapped_column(sql.String(255))

    sql.PrimaryKeyConstraint(CategoryID, name="pk_category_categoryid")

    def __repr__(self) -> str:
        return f"Category(ID={self.CategoryID}, Name={self.Name}, Description={self.Description})"

class SubCategory(Base):
    __tablename__ = "subcategories"

    SubcategoryID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Image:orm.Mapped[str] = orm.mapped_column(sql.String(255))

    sql.PrimaryKeyConstraint(SubcategoryID, name="pk_subcategory_subcategoryid")

    def __repr__(self) -> str:
        return f"SubCategory(ID={self.SubcategoryID}, Name={self.Name}, Description={self.Description})"

class ProductCategory(Base):
    __tablename__ = "product_categories"

    ProductID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    CategoryID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    SubCategoryID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)

    sql.PrimaryKeyConstraint(ProductID, CategoryID, SubCategoryID, name="pk_product_categories_productid_categoryid_subcategoryid")
    sql.ForeignKeyConstraint([ProductID], [Products.ProductID], name="fk_product_categories_productid")
    sql.ForeignKeyConstraint([CategoryID], [Category.CategoryID], name="fk_product_categories_categoryid")
    sql.ForeignKeyConstraint([SubCategoryID], [SubCategory.SubcategoryID], name="fk_product_categories_subcategoryid")

    def __repr__(self) -> str:
        return f"Product_Categories(ProductID={self.ProductID}, CategoryID={self.CategoryID}), SubCategoryID={self.SubCategoryID})"

class Batch(Base):
    __tablename__ = "batches"

    BatchID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    ProductID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Quantity:orm.Mapped[int] = orm.mapped_column(sql.Integer)
    ManufactureDate:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME, nullable=False)
    RetailerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    SupplierID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)

    sql.PrimaryKeyConstraint(BatchID, name="pk_batches_batchid")
    sql.ForeignKeyConstraint([RetailerID], [Retailer.RetailerID], name="fk_batches_retailerid")
    sql.ForeignKeyConstraint([SupplierID], [Supplier.SupplierID], name="fk_batches_supplierid")

    def __repr__(self) -> str:
        return f"Batch(ID={self.BatchID}, ProductID={self.ProductID}, Quantity={self.Quantity}, ManufactureDate={self.ManufactureDate}, RetailerID={self.RetailerID}, SupplierID={self.SupplierID})"

class Supply_Order(Base):
    __tablename__ = "supply_orders"


    OrderID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    OrderDate:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME, nullable=False)
    Amount:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)
    Status:orm.Mapped[enum.Enum] = orm.mapped_column(sql.Enum(*[status.value for status in Status]))

    sql.PrimaryKeyConstraint(OrderID, name="pk_supply_orders_orderid")

    def __repr__(self) -> str:
        return f"Supply_Order(ID={self.OrderID}, OrderDate={self.OrderDate}, Amount={self.Amount}, Status={self.Status})"

class OrderBatch(Base):
    __tablename__ = "order_batches"

    OrderID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    BatchID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)

    sql.PrimaryKeyConstraint(OrderID, BatchID, name="pk_order_batches_orderid_batchid")
    sql.ForeignKeyConstraint([OrderID], [Supply_Order.OrderID], name="fk_order_batches_orderid")
    sql.ForeignKeyConstraint([BatchID], [Batch.BatchID], name="fk_order_batches_batchid")

    def __repr__(self) -> str:
        return f"OrderBatch(OrderID={self.OrderID}, BatchID={self.BatchID})"

class ProductSupplier(Base):
    __tablename__ = "product_suppliers"

    ProductID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    SupplierID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)

    sql.PrimaryKeyConstraint(ProductID, SupplierID, name="pk_product_suppliers_productid_supplierid")
    sql.ForeignKeyConstraint([ProductID], [Products.ProductID], name="fk_product_suppliers_productid")
    sql.ForeignKeyConstraint([SupplierID], [Supplier.SupplierID], name="fk_product_suppliers_supplierid")

    def __repr__(self) -> str:
        return f"ProductSupplier(ProductID={self.ProductID}, SupplierID={self.SupplierID})"

class Inventory(Base):
    __tablename__ = "inventory"

    BatchID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    RetailerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    QuantityRemaining:orm.Mapped[int] = orm.mapped_column(sql.Integer, nullable=False)

    sql.PrimaryKeyConstraint(BatchID, RetailerID, name="pk_inventory_batchid_retailerid")
    sql.ForeignKeyConstraint([BatchID], [Batch.BatchID], name="fk_inventory_batchid")
    sql.ForeignKeyConstraint([RetailerID], [Retailer.RetailerID], name="fk_inventory_retailerid")

    def __repr__(self) -> str:
        return f"Inventory(BatchID={self.BatchID}, RetailerID={self.RetailerID}, QuantityRemaining={self.QuantityRemaining})"

class ProductOrder(Base):
    __tablename__ = "product_orders"

    OrderID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    CustomerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    OrderDate:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME, nullable=False)
    Quantity:orm.Mapped[int] = orm.mapped_column(sql.Integer, nullable=False)
    Amount:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)
    Status:orm.Mapped[enum.Enum] = orm.mapped_column(sql.Enum(*[status.value for status in Status]))
    DeliveryMethod:orm.Mapped[enum.Enum] = orm.mapped_column(sql.Enum(*[delivery.value for delivery in Delivery]))
    PaymentMethod:orm.Mapped[enum.Enum] = orm.mapped_column(sql.Enum(*[payment.value for payment in Payment]))

    sql.PrimaryKeyConstraint(OrderID, name="pk_product_orders_orderid")
    sql.ForeignKeyConstraint([CustomerID], [Customer.CustomerID], name="fk_product_orders_customerid")

    def __repr__(self) -> str:
        return f"ProductOrder(OrderID={self.OrderID}, CustomerID={self.CustomerID}, OrderDate={self.OrderDate}, Quantity={self.Quantity}, Amount={self.Amount}, Status={self.Status}, DeliveryMethod={self.DeliveryMethod}, PaymentMethod={self.PaymentMethod})"

class ProductOrderItem(Base):
    __tablename__ = "product_order_items"

    OrderID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    ProductID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    CustomerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    RetailerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Quantity:orm.Mapped[int] = orm.mapped_column(sql.Integer, nullable=False)
    Amount:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)

    sql.PrimaryKeyConstraint(OrderID, ProductID, CustomerID, RetailerID, name="pk_product_order_items_orderid_productid_customerid_retailerid")
    sql.ForeignKeyConstraint([OrderID], [ProductOrder.OrderID], name="fk_product_order_items_orderid")
    sql.ForeignKeyConstraint([ProductID], [Products.ProductID], name="fk_product_order_items_productid")
    sql.ForeignKeyConstraint([CustomerID], [Customer.CustomerID], name="fk_product_order_items_customerid")
    sql.ForeignKeyConstraint([RetailerID], [Retailer.RetailerID], name="fk_product_order_items_retailerid")

    def __repr__(self) -> str:
        return f"ProductOrderItem(OrderID={self.OrderID}, ProductID={self.ProductID}, CustomerID={self.CustomerID}, RetailerID={self.RetailerID}, Quantity={self.Quantity}, Amount={self.Amount})"

class Test(Base):
    __tablename__ = "tests"

    TestID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(127))
    Image:orm.Mapped[str] = orm.mapped_column(sql.String(255))
    Description:orm.Mapped[str] = orm.mapped_column(sql.String(8191))
    Price:orm.Mapped[float] = orm.mapped_column(sql.Float, nullable=False)
    LabID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)

    sql.PrimaryKeyConstraint(TestID, name="pk_tests_testid")
    sql.ForeignKeyConstraint([LabID], [MedicalLab.LabID], name="fk_tests_landid")

    def __repr__(self) -> str:
        return f"Test(TestID={self.TestID}, Name={self.Name}, Image={self.Image}, Description={self.Description}, Price={self.Price}, LabID={self.LabID})"

class Appointment(Base):
    __tablename__ = "appointments"

    AppointmentID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    TestID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    CustomerID:orm.Mapped[str] = orm.mapped_column(sql.String(36), nullable=False)
    BookingDate:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME, nullable=False)
    AppointmentDate:orm.Mapped[datetime.datetime] = orm.mapped_column(sql.DATETIME, nullable=False)
    Result:orm.Mapped[str] = orm.mapped_column(sql.String(8191))

    sql.PrimaryKeyConstraint(AppointmentID, name="pk_appointments_appointmentid")
    sql.ForeignKeyConstraint([TestID], [Test.TestID], name="fk_appointments_testid")
    sql.ForeignKeyConstraint([CustomerID], [Customer.CustomerID], name="fk_appointments_customerid")

    def __repr__(self) -> str:
        return f"Appointment(AppointmentID={self.AppointmentID}, TestID={self.TestID}, CustomerID={self.CustomerID}, BookingDate={self.BookingDate}, AppointmentDate={self.AppointmentDate}, Result={self.Result})"