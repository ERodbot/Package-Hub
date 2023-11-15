from fastapi import APIRouter, HTTPException, status
from config.database import db_dependency
from schemas.client import Client, ClientCreate, test
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError


client = APIRouter()

@client.post("/test")
def testing(test: test, db: db_dependency):
    test_dict = test.model_dump()
    query = text("""EXEC test @address=:address, @postalCode=:postal_code""")
    params = {
        'address': test_dict['address'],
        'postal_code': test_dict['postal_code']
    }

    try:
        db.execute(query, params)
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return test_dict

@client.post("/registerClient")
def createClient(client: ClientCreate, db: db_dependency):
    client_dict = client.model_dump()
    query = text("""
                EXEC registerClient 
                @name=:name, 
                @lastName=:lastname, 
                @username=:username, 
                @email=:email, 
                @phone=:phone,
                @address=:address, 
                @city=:city, 
                @country=:country, 
                @postalCode=:postal_code, 
                @password=:password""")
    params = {
                'name': client_dict['name'], 
                'lastname': client_dict['lastname'], 
                'username': client_dict['username'], 
                'email': client_dict['email'], 
                'phone': client_dict['telephone'], 
                'address': client_dict['street'], 
                'city': client_dict['city'], 
                'country': client_dict['country'], 
                'postal_code': client_dict['postal_code'], 
                'password': client_dict['password']
              }

    try:
        db.execute(query, params)
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)


    return client_dict

    
@client.get("/getClient/{id}", response_model = Client)
def getClient(id: int, db: db_dependency):
    # Llama al procedimiento almacenado en la base de datos
    query = "EXEC ObtenerCliente @Id=:id"
    params = {"id": id}
    
    try:
        user = db.execute(query, params).fetchone()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    return user