from fastapi import APIRouter, HTTPException, status
from config.database import db_dependency
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError

reporting = APIRouter(
    tags=["reporting"],
)

@reporting.get("/getRoles")
def getRoles(db: db_dependency):
    query = text("""SELECT name FROM [hr].[human-resources]..Role""")
    try:
        roles = db.execute(query).fetchall()

        # Make the dictionary to return
        roles_dict = []
        for row in roles:
            roles_dict.append({
                'name': row[0]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return roles_dict

@reporting.get("/getProducts")
def getProducts(db: db_dependency):
    query = text("""SELECT name FROM [na-inventory].[inventory].[dbo].Products""")
    try:
        products = db.execute(query).fetchall()

        # Make the dictionary to return
        products_dict = []
        for product in products:
            products_dict.append({
                'name': product[0]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return products_dict

@reporting.get("/getCategories")
def getCategories(db: db_dependency):
    query = text("""SELECT name FROM [na-inventory].[inventory].[dbo].[Category]""")
    try:
        categories = db.execute(query).fetchall()

        # Make the dictionary to return
        categories_dict = []
        for category in categories:
            categories_dict.append({
                'name': category[0]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return categories_dict


@reporting.get("/getPerformance")
def getPerformance(db: db_dependency, start_date: str | None = None, end_date: str | None = None, role: str  | None = None, country: str | None = None):

    query = text("""EXEC usp_ReportingByPerformance @initial_date=:start_date, @final_date=:end_date, @role_filter=:role, @country_filter=:country""")
    params = {
        'start_date': start_date,
        'end_date': end_date,
        'role': role,
        'country': country
    }
    try:
        perfomance = db.execute(query, params).fetchall()

        # Make the dictionary to return
        perfomance_dict = []
        for row in perfomance:
            perfomance_dict.append({
                'name': row[0],
                'last_name': row[1],
                'rating': row[2],
                'email': row[4],
                'department': row[5],
                'role': row[6],
                'country': row[7],
                'state': row[8],
                'city': row[9],
                'address': row[10]
            })
        

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return perfomance_dict


@reporting.get("/getPayroll")
def getPayroll(db: db_dependency, start_date: str | None = None, end_date: str | None = None):

    query = text("""usp_ReportingSalaryStructure @initial_date=:start_date, @final_date=:end_date""")
    params = {
        'start_date': start_date,
        'end_date': end_date
    }
    try:
        payroll = db.execute(query, params).fetchall()

        # Make the dictionary to return
        payroll_dict = []
        for row in payroll:
            payroll_dict.append({
                'name': row[0],
                'lastName': row[1],
                'role': row[2],
                'country': row[3],
                'startDate': row[4],
                'endDate': row[5],
                'grossSalary': row[6],
                'netSalary': row[7],
                'deductions': row[8],
                'percentage': row[9]
            })
        
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return payroll_dict


@reporting.get("/getVentas")
def getVentas(db: db_dependency, productName: str | None = None, categoryName: str | None = None, startDate: str | None = None):

    query = text("""EXEC viewReport""")
    try:
        ventas = db.execute(query)
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    query = text("""SELECT * FROM dbo.TempReportResults WHERE (:productName IS NULL OR productName LIKE :productName) AND (:categoryName IS NULL OR categoryName LIKE :categoryName) AND (:startDate IS NULL OR orderDate >= :startDate)""")
    params = {
        'productName': productName,
        'categoryName': categoryName,
        'startDate': startDate
    }

    try:
        rVentas = db.execute(query, params).fetchall()

        # Make the dictionary to return
        reporteVentas = []
        for row in rVentas:
            reporteVentas.append({
                'clientName': row[0],
                'clientEmail': row[1],
                'orderDate': row[2],
                'productName': row[3],
                'categoryName': row[4],
                'quantity': row[5],
                'Total': row[6]
            })
        

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    return reporteVentas

@reporting.get("/getTickets")
def getTickets(db: db_dependency):
    query = text("""SELECT * FROM OPENQUERY([support-sales], 'SELECT * FROM public.getTicketInfo()')""")

    try:
        responseTickets = db.execute(query).fetchall()

        # Make the dictionary to return
        reporteTickets = []
        for row in responseTickets:
            reporteTickets.append({
                'idTicket': row[0],
                'description': row[1],
                'createdAt': row[2],
                'updateAt': row[3],
                'idTicketType': row[4],
                'idOrder': row[5],
                'clientName': row[6]
            })
        
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    return reporteTickets



@reporting.get("/getEmployeeOrders")
def getEmployeeOrders(db: db_dependency, usernameclient: str | None = None, email: str | None = None):
    query = text("""EXEC usp_GetOrdersList @usernameclient=:usernameclient, @email=:email""")
    params = {
        'usernameclient': usernameclient,
        'email': email
    }
    try:
        ordersE = db.execute(query, params).fetchall()
        orders_dict = []
        for order in ordersE:
            orders_dict.append({
                'idOrder': order[0], 
                'invoiceNumber': order[1], 
                'emissionDate': order[2], 
                'status': order[3], 
                'clientName': order[4],
                'clientLastname': order[5],
                'clientUsername': order[6], 
                'distance': order[7]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return orders_dict


@reporting.get("/getClientOrders")
def getClientOrders(db: db_dependency, usernameclient: str | None = None, email: str | None = None):
    query = text("""EXEC usp_GetOrdersListClient @usernameclient=:usernameclient, @email=:email""")
    params = {
        'usernameclient': usernameclient,
        'email': email
    }
    try:
        ordersC = db.execute(query, params).fetchall()
        ordersC_dict = []
        for order in ordersC:
            ordersC_dict.append({
                'invoiceNumber': order[0], 
                'emissionDate': order[1], 
                'status': order[2], 
                'distance': order[3]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return ordersC_dict
