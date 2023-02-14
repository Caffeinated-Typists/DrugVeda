import typing
import sqlalchemy as sql
import sqlalchemy.orm as orm

class Base(orm.DeclarativeBase):
    pass

class Customer(Base):
    __tablename__ = "customers"

    CustomerID:orm.Mapped[int] = orm.mapped_column(sql.String(36), primary_key=True, nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)

    def __repr__(self) -> str:
        return f"Customer(ID={self.CustomerID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"

class Retailer(Base):
    __tablename__ = "retailers"

    RetailerID:orm.Mapped[int] = orm.mapped_column(sql.String(36), primary_key=True, nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Manager:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)

    def __repr__(self) -> str:
        return f"Retailer(ID={self.RetailerID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon}, Manager={self.Manager})"

class Supplier(Base):
    __tablename__ = "suppliers"

    SupplierID:orm.Mapped[int] = orm.mapped_column(sql.String(36), primary_key=True, nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)

    def __repr__(self) -> str:
        return f"Supplier(ID={self.SupplierID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"

class Brands(Base):
    __tablename__ = "brands"

    BrandID:orm.Mapped[int] = orm.mapped_column(sql.String(36), primary_key=True, nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)
    ProductCnt:orm.Mapped[int] = orm.mapped_column(sql.Integer)

    def __repr__(self) -> str:
        return f"Brand(ID={self.BrandID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon}, ProductCnt={self.ProductCnt})"

class Medical_Labs(Base):
    __tablename__ = "medical_labs"

    LabID:orm.Mapped[int] = orm.mapped_column(sql.String(36), primary_key=True, nullable=False)
    Name:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False)
    Email:orm.Mapped[str] = orm.mapped_column(sql.String(255), nullable=False, index=True)
    Phone:orm.Mapped[str] = orm.mapped_column(sql.String(20))
    Lat:orm.Mapped[float] = orm.mapped_column(sql.Float)
    Lon:orm.Mapped[float] = orm.mapped_column(sql.Float)
    
    def __repr__(self) -> str:
        return f"Medical_Lab(ID={self.LabID}, Name={self.Name}, Email={self.Email}, Phone={self.Phone}, Lat={self.Lat}, Lon={self.Lon})"