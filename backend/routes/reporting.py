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