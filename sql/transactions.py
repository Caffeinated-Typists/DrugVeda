async def delete_product(request:Request, token:str = Depends(token_auth_scheme)):
    user_token:str = token.credentials
    if user_token is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Token is missing"})
    brand_id:str = users.get_uid_using_token(user_token)
    if brand_id is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "Invalid token"})
    role:str = user.get_role_from_firestore(brand_id)
    if role != "brand":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"status": "error", "msg": "You are not authorized to perform this action"})
    req = await request.json()
    product_id:str = req.get("product_id")
    if product_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product id is missing"})
    try:
        db = mysql.connec(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION;")
        cursor.execute("DELETE FROM Products WHERE ProductID = '{}'';".format(product_id))
        cursor.execute("COMMIT;")
        cursor.close()
    except Exception as e:
        return JSONResponse(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, content={"status": "error", "msg": "Error while deleting product"})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product deleted successfully"})

async def create_product_order(request: Request, token: str = Depends(token_auth_scheme)):
    """Create a product order in the database"""
    req = await request.json()
    user_token = token.credentials
    cart = req.get("cart")
    delivery_method = req.get("delivery_method")
    payment_method = req.get("payment_method")
    subtotal = req.get("subtotal")
    if(user_token is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    if(cart is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Cart is missing"})
    if(delivery_method is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Delivery method is missing"})
    if(payment_method is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Payment method is missing"})
    if(subtotal is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Subtotal is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if(role != 'customer'):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can create product orders"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    possible = True
    buy_from:dict[str, str] = {}
    for item in cart:
        if item["pid"] is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product ID is missing"})
        if item["quantity"] is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Quantity is missing"})
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select inventory.RetailerID from inventory, batches 
            where inventory.BatchID = batches.BatchID and batches.ProductID = "{}" and inventory.QuantityRemaining > {};
        """.format(item["pid"], item["quantity"]))
        available_retailers = cursor.fetchall()
        if(len(available_retailers) == 0):
            possible = False
            cursor.execute("ROLLBACK;")
            buy_from[item["pid"]] = None
        else:
            buy_from[item["pid"]] = available_retailers[0][0]
        cursor.execute("ROLLBACK;")
    if not possible:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": f"Not enough stock for products {[item['pid'] for item in cart if buy_from[item['pid']] is None]}"})
    cursor.execute("START TRANSACTION;")
    orderid = uuid.uuid1().hex
    cursor.execute("""
        insert into product_orders (OrderID, CustomerID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod)
        values ("{}", "{}", "{}", {}, {}, "Placed", "{}", "{}");
    """.format(orderid, user_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), sum([item["quantity"] for item in cart]), subtotal, delivery_method, payment_method))
    for item in cart:
        cursor.execute("""select Price from products where ProductID = "{}";""".format(item["pid"]))
        item_price = cursor.fetchone()[0]
        cursor.execute("""
            insert into product_order_items (OrderID, CustomerID, ProductID, RetailerID, Quantity, Amount)
            values ("{}", "{}", "{}", "{}", {}, {});
        """.format(orderid, user_id, item["pid"], buy_from[item["pid"]], item["quantity"], item["quantity"]*item_price))
    cursor.execute("COMMIT;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product order created successfully", "orderid": orderid})

async def get_order_history(token: str = Depends(token_auth_scheme)):
    """Returns the product order history for the given Customer ID"""
    user_token = token.credentials
    customer_id = get_uid_using_token(user_token)
    role = get_role_from_firestore(customer_id)
    if role != 'customer':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can view product order history"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select OrderID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod from product_orders where CustomerID = "{}";
    """.format(customer_id))
    orders = [{"orderid": i[0], "orderdate": i[1], "quantity": i[2], "amount": i[3], "status": i[4], "deliverymethod": i[5], "paymentmethod": i[6]} for i in cursor.fetchall()]
    cursor.execute("ROLLBACK;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Product order history fetched successfully", "orders": orders})

async def complete_product_order(request: Request, token: str = Depends(token_auth_scheme)):
    """Complete a product order in the database"""
    user_token = token.credentials
    if(user_token is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if(role != 'retailer'):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only retailers can complete product orders"})
    req = await request.json()
    order_id = req.get("order_id")
    if(order_id is None):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Order ID is missing"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""SELECT ProductID, Quantity FROM product_order_items where OrderID = '{}' and RetailerID = '{}'""".format(order_id, user_id))
    order_items = [{"pid": x[0], "qty": x[1]} for x in cursor.fetchall()]
    if(len(order_items) == 0):
        cursor.execute("ROLLBACK;")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid order ID"})
    for order_item in order_items:
        cursor.execute("""SELECT QuantityRemaining from product_inventory_view where ProductID = '{}' and RetailerID = '{}'""".format(order_item["pid"], user_id))
        qty_remaining = cursor.fetchone()[0]
        if qty_remaining < order_item["qty"]:
            cursor.execute("ROLLBACK;")
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Insufficient quantity"})
    for order_item in order_items:
        cursor.execute("CALL sell_product('{}', '{}', '{}')".format(user_id, order_item["pid"], order_item["qty"]))
    cursor.execute("COMMIT;")
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Order completed successfully"})  

async def get_product_order(orderid:str, token: str = Depends(token_auth_scheme)):
    """Returns the product order details for the given Order ID (Customer Endpoint)"""
    user_token = token.credentials
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select CustomerID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod from product_orders where OrderID = "{}";
    """.format(orderid))
    order = cursor.fetchone()
    if order is None:
        cursor.execute("ROLLBACK;")
        db.close()
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Product order not found"})
    cursor.execute("""
        select ProductID, Quantity from product_order_items where OrderID = "{}";
    """.format(orderid))
    items = [{"pid" : i[0], "quantity" : i[1]} for i in cursor.fetchall()]
    cursor.execute("ROLLBACK;")
    db.close()
    if order[0] != get_uid_using_token(user_token):
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Not Authorized to view this product order"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={
        "status": "success", 
        "msg": "Product order fetched successfully", 
        "orderid": orderid, 
        "orderdate": order[1], 
        "quantity": order[2], 
        "amount": order[3], 
        "status": order[4], 
        "deliverymethod": order[5], 
        "paymentmethod": order[6], 
        "items": items}
    )

async def create_supply_order(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    uid = get_uid_using_token(user_token)
    role = get_role_from_firestore(uid)
    if role != "retailer":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    req = await request.json()
    cart = req.get("cart")
    total_price = req.get("total_price")
    order_id = uuid.uuid1().hex
    try:
        db = mysql.connect(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION")
        cursor.execute("""
            INSERT INTO supply_orders (OrderID, OrderDate, Amount, Status) values ("{}","{}","{}", "Placed")
        """.format(order_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), total_price))
        for item in cart:
            if item.get('pid') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Product ID not provided"})
            if item.get('quantity') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Quantity not provided"})
            if item.get('supplierid') is None:
                return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": "Supplier ID not provided"})
            batch_id = uuid.uuid1().hex
            cursor.execute("""
                INSERT INTO order_batches (OrderID, BatchID) values ("{}","{}")
            """.format(order_id, batch_id))
            cursor.execute("""
                INSERT INTO batches (BatchID, ProductID, Quantity, RetailerID, SupplierID) values ("{}","{}","{}","{}","{}")
            """.format(batch_id, item.get('pid'), item.get('quantity'), uid, item.get('supplierid')))
        cursor.execute("COMMIT")
    except Exception as e:
        cursor.execute("ROLLBACK")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": str(e)})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"msg": "Order placed successfully", "order_id": order_id})

async def complete_supply_order(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    uid = get_uid_using_token(user_token)
    if uid is None:
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    role = get_role_from_firestore(uid)
    if role != "supplier":
        return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED, content={"msg": "Unauthorized access"})
    req = await request.json()
    order_id = req.get("order_id")
    try:
        cursor.execute("START TRANSACTION")
        cursor.execute("""
            SELECT BatchID FROM order_batches WHERE OrderID = "{}"
        """.format(order_id))
        batch_ids = [item[0] for item in cursor.fetchall()]
        for batch_id in batch_ids:
            cursor.execute("""
                UPDATE batches SET ManufactureDate = "{}" WHERE BatchID = "{}"
            """.format(datetime.now().strftime("%Y-%m-%d %H:%M:%S"), batch_id))
        cursor.execute("COMMIT")
    except Exception as e:
        cursor.execute("ROLLBACK")
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"msg": str(e)})
    finally:
        db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"msg": "Order completed successfully"})

async def create_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    """Create an appointment in the database"""
    req = await request.json()
    user_token = token.credentials
    test_id = req.get("test_id")
    appointment_date = req.get("date")
    if user_token is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User token is missing"})
    if test_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Test ID is missing"})
    if appointment_date is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment date is missing"})
    user_id = get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'customer':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only customers can create appointments"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    try:
        cursor.execute("START TRANSACTION;")
        appointment_id = uuid.uuid1().hex
        cursor.execute("""
            insert into appointments (AppointmentID, TestID, CustomerID, BookingDate, AppointmentDate) 
            values ('{}', '{}', '{}', '{}', '{}');
        """.format(appointment_id, test_id, user_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S"), appointment_date))
        cursor.execute("COMMIT;")
    except Exception as e:
        appointment_id = None
        cursor.execute("ROLLBACK;")
    finally:
        db.close()
    if appointment_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment could not be created"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointment created successfully", "appointment_id": appointment_id})

async def get_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    """Get all the appointments of a Medical Lab"""
    user_token = token.credentials
    lab_id:str = users.get_uid_using_token(user_token)
    if lab_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role:str = users.get_role_from_firestore(lab_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'medical_lab':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs can get appointments"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("START TRANSACTION;")
    cursor.execute("""
        select tests.TestID, customers.CustomerID, appointments.AppointmentDate
        from appointments
        right join tests on tests.TestID = appointments.TestID
        right join medical_labs on medical_labs.LabID = tests.LabID
        right join customers on customers.CustomerID = appointments.CustomerID
        where medical_labs.LabID = '{}'
        order by appointments.AppointmentDate;
    """.format(lab_id))
    appointments = cursor.fetchall()
    cursor.execute("COMMIT;")
    db.close()
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointments fetched successfully", "appointments": [{"test_id" : appointment[0], "customer_id" : appointment[1], "appointment_date" : appointment[2]} for appointment in appointments]})

async def complete_appointment(request: Request, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    user_id = users.get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = users.get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role != 'medical_lab':
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs can complete appointments"})
    req = await request.json()
    appointment_id = req.get("appointment_id")
    if appointment_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment ID is missing"})
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    check:Bool = False
    try:
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select tests.LabID from appointments, tests 
            where tests.TestID = appointments.TestID and appointments.AppointmentID = '{}';
            """.format(appointment_id))
        lab_id = cursor.fetchone()[0]
        if lab_id != user_id:
            cursor.execute("COMMIT;")
            db.close()
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment does not belong to this lab"})
        cursor.execute("""
            update appointments set AppointmentStatus = 'completed' where AppointmentID = '{}';
            """.format(appointment_id))
        cursor.execute("COMMIT;")
        check = True
    except Exception as e:
        cursor.execute("ROLLBACK;")
        check = False
    finally:
        db.close()
    if not check:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment could not be completed"})
    return JSONResponse(status_code=status.HTTP_200_OK, content={"status": "success", "msg": "Appointment completed successfully"})

async def get_appointment_details(request: Request, AppointmentID: str, token: str = Depends(token_auth_scheme)):
    user_token = token.credentials
    user_id = users.get_uid_using_token(user_token)
    if user_id is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Invalid user token"})
    role = users.get_role_from_firestore(user_id)
    if role is None:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "User not found in firestore"})
    if role == 'medical_lab' or role == 'customer':
        db = mysql.connect(
            host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
            user = os.environ['MySQL_USER'],
            passwd = os.environ['MySQL_PASSWORD'],
            database = "DrugVeda"
        )
        cursor = db.cursor()
        cursor.execute("START TRANSACTION;")
        cursor.execute("""
            select * from appointments where AppointmentID = '{}';
            """.format(AppointmentID))
        appointment = cursor.fetchone()
        cursor.execute("COMMIT;")
        db.close()
        if appointment is None:
            return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Appointment not found"})
        return JSONResponse(status_code=status.HTTP_200_OK, content={
                "status": "success", 
                "msg": "Appointment fetched successfully", 
                "appointment": {"appointment_id" : appointment[0], "test_id" : appointment[1], "customer_id" : appointment[2], "booking_date" : appointment[3], "appointment_date" : appointment[4], "appointment_status" : appointment[5]}
            })
    else:
        return JSONResponse(status_code=status.HTTP_400_BAD_REQUEST, content={"status": "error", "msg": "Only labs and customers can get appointments"})    