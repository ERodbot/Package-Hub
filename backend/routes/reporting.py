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
    query = text("""SELECT name FROM [na-inventory].[inventory].[dbo].[Products]""")
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
                'percentage': row[9],
            })
        
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return payroll_dict

@reporting.get("/getReportVentas")
def getReportVentas(db: db_dependency, productName: str | None = None, categoryName: str | None = None, startDate: str | None = None):

    query = text("""EXEC viewReport @productName=:productName, @categoryName=:categoryName, @startDate=:startDate""")
    params = {
        'productName': productName,
        'categoryName': categoryName,
        'startDate': startDate,
    }
    try:
        reportVentas = db.execute(query, params).fetchall()

        # Make the dictionary to return
        reportSales = []
        for rowS in reportVentas:
            reportSales.append({
                'clientName': rowS[0],
                'clientEmail': rowS[1],
                'orderDate': rowS[2],
                'productName': rowS[3],
                'categoryName': rowS[4],
                'quantity': rowS[5],
                'Total': rowS[6]
            })
        

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    return reportSales


@reporting.get("/getVentas")
def getVentas(db: db_dependency):
    query = text("""SELECT * FROM dbo.TempReportResults""")

    try:
        rVentas = db.execute(query).fetchall()

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


