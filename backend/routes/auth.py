from datetime import datetime, timedelta
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, Form
from pydantic import BaseModel
from sqlalchemy.orm import Session
from starlette import status
from config.database import db_dependency
from models.client import Client
from passlib.context import CryptContext
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from schemas.client import ClientCreate, Client as clientSchema
from schemas.client import Client, ClientCreate, test, ClientLogin
from config.auth import ALGORITHM, SECRET_KEY
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError
from typing import List, Dict

auth = APIRouter(
    tags=["auth"],
)


bcrypt = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_bearer = OAuth2PasswordBearer(tokenUrl="auth/token")


@auth.post("/registerClient")
def createClient(client: ClientCreate, db: db_dependency):
    client_dict = client.dict()

    # hash the password
    hashed_password = bcrypt.hash(client_dict['password'])
    client_dict['password'] = hashed_password
    # check if the password is the same as hashed
    # print(bcrypt.verify(client_dict['password'], hashed_password))
    client_dict['postal_code'] = int(client_dict['postal_code'])

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
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)


    return client_dict

@auth.get("/getCountry", response_model=List[Dict[str, str]])
def getCountry(db: db_dependency):
    query = text("""SELECT name FROM [hr].[human-resources]..Country""")
    try:
        result = db.execute(query).fetchall()
        
        # Convert result to a list of dictionaries
        countries = [{"name": row[0]} for row in result]
        
        return countries  # FastAPI automatically converts this to JSON

    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)


@auth.get("/getState/{country_name}", response_model=List[Dict[str, str]])
def getState(country_name: str, db: db_dependency):

    query = text(f"""SELECT idCountry FROM [hr].[human-resources]..Country WHERE name = '{country_name}'""")
    try:
        result = db.execute(query).fetchone()
        idCountry = result[0]
    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    query = text(f"""SELECT name FROM [hr].[human-resources]..State WHERE idCountry = '{idCountry}'""")
    try:
        result = db.execute(query).fetchall()
        
        # Convert result to a list of dictionaries
        states = [{"name": row[0]} for row in result]
        
        return states  # FastAPI automatically converts this to JSON

    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

@auth.get("/getCity/{state_name}", response_model=List[Dict[str, str]])
def getState(state_name: str, db: db_dependency):

    query = text(f"""SELECT idState FROM [hr].[human-resources]..State WHERE name = '{state_name}'""")
    try:
        result = db.execute(query).fetchone()
        idState = result[0]
    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    query = text(f"""SELECT name FROM [hr].[human-resources]..City WHERE idState = '{idState}'""")
    try:
        result = db.execute(query).fetchall()
        
        # Convert result to a list of dictionaries
        states = [{"name": row[0]} for row in result]
        
        return states  # FastAPI automatically converts this to JSON

    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)


@auth.post("/loginClient")
def loginClient(client: ClientLogin, db: db_dependency):
    client_dict = client.model_dump()
    query = text("""EXEC loginClient @username=:username, @password=:password""")
    params = {
                'username': client_dict['username'], 
                'password': client_dict['password']
              }

    try:
        db.execute(query, params)
    except DBAPIError as e:
        error_message = e.args[0]
        # raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
        if 'User does not exist' in error_message:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='User does not exist')
        elif 'Wrong password' in error_message:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Wrong password')
        else:
            # If the error message doesn't match any specific case, return a generic 406 status code
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

    return client_dict













# @auth.post("/registerClient", response_model = clientSchema)
# def create_client(client: ClientCreate, db: db_dependency):
#     if client.username is None or client.name is None or client.lastname is None or client.email is None or client.telephone is None or client.password is None:
#         return HTTPException(status_code=400, detail="Missing fields")
#     query = text("""
#         DECLARE @Resultado INT;
#         EXEC CreateClient
#             @Username=:username,
#             @Name=:name,
#             @Lastname=:lastname,
#             @Email=:email,
#             @Telephone=:telephone,
#             @Password=:password,
#             @Resultado = @Resultado OUTPUT;
#         SELECT @Resultado as Resultado;
#     """)

#     hashed_password = bcrypt.hash(client.password)

#     params = {
#         "username": client.username,
#         "name": client.name,
#         "lastname": client.lastname,
#         "email": client.email,
#         "telephone": client.telephone,
#         "password": hashed_password,
#     }

#     try:
#         result = db.execute(query, params).fetchone()
#         if result and result.Resultado == 1:
#             db.commit()
#             return client
#         else:
#             raise HTTPException(status_code=500, detail="Failed to create client")
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))
    
# @auth.post("/loginClient", response_model = clientSchema)
# def login_client(db: db_dependency, form_data: OAuth2PasswordRequestForm = Depends()):
#     query = text("""
#         DECLARE @Resultado INT;
#         EXEC IniciarSesionCliente
#             @Username=:username,
#             @Password=:password,
#             @Resultado = @Resultado OUTPUT;
#         SELECT @Resultado as Resultado;
#     """)

#     params = {
#         "username": form_data.username,
#         "password": form_data.password,
#     }

#     try:
#         result = db.execute(query, params).fetchone()
#         if result and result.Resultado == 1:
#             db.commit()
#             return clientSchema(username=form_data.username)
#         else:
#             raise HTTPException(status_code=401, detail="Invalid credentials")
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))


# BIEN ! :D


@auth.post("/token")
async def login_for_access_token(form_data: Annotated[OAuth2PasswordRequestForm, Depends()], db: db_dependency):
    client = await authenticate_client(form_data.username, form_data.password, db)
    if not client:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    access_token = create_access_token(
        data={"sub": client.username}, expires_delta=timedelta(minutes=20)
    )
    return {"access_token": access_token, "token_type": "bearer"}

def authenticate_client(username: str, password: str, db: Session):
    user = db.query(Client).filter(Client.username == username).first()
    if not user:
        return False
    if not verify_password(password, user.password):
        return False
    return user

def verify_password(plain_password, hashed_password):
    return bcrypt.verify(plain_password, hashed_password)

def create_access_token(username: str, id = int, expires_delta: timedelta = None):
    encode = {"sub" : username, "id" : id}
    expires = datetime.utcnow() + timedelta(minutes=20)
    encode.update({"exp": expires})
    return jwt.encode(encode, SECRET_KEY, algorithm=ALGORITHM)

async def get_current_user(token: Annotated[str, Depends(oauth2_bearer)]):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        id: int = payload.get("id")
        if username is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")
        return {"username": username, "id": id}
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")

