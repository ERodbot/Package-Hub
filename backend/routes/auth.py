from datetime import datetime, timedelta
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, Form, status, Response, Request, Cookie
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
def loginClient(client: ClientLogin, response: Response, db: db_dependency):
    client_dict = client.model_dump()
    query = text("""SELECT password FROM [support-sales].[support-sales].[sales].Clients WHERE username = :username""")
    params = {
        'username': client_dict['username'],
    }
    try:
        user = db.execute(query, params).fetchone()
        pwd_db = user[0]
        if pwd_db:
            validate = bcrypt.verify(client_dict['password'], pwd_db)
            if validate:
                # El usuario y contraseña son válidos, procede con la creación del token
                access_token = create_access_token(
                    username=client_dict['username'],  # Ajusta esto según tu modelo de datos
                    expires_delta=timedelta(minutes=20)
                )
                # Devuelve el token en lugar del usuario
                response.set_cookie(key="token", value=access_token, httponly=False)
                return {'status': status.HTTP_200_OK, 'data': {}}
            
        # Si no se encontró el usuario, se levanta una excepción
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")

    except DBAPIError as e:
        error_message = e.args[0]
        if 'User does not exist' in error_message:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='User does not exist')
        elif 'Wrong password' in error_message:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Wrong password')
        else:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=error_message)
        

# username = "xd"
#     query = text("""SELECT password FROM [support-sales].[support-sales].[sales].Clients WHERE username = :username""")
#     params = {"username": username}

#     try:
#         result = db.execute(query, params).fetchone()
#         if result is None:
#             raise HTTPException(status_code=404, detail="User not found")
#         else:
#             password = result[0]
#     except DBAPIError as e:
#         error_message = e.args[0]
#         raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)

#     status = bcrypt.verify(pwd, password)

#     if status:
#         return {"detail": "Password is correct"}
#     else:
#         raise HTTPException(status_code=200 , detail="Password is incorrect")

def create_access_token(username: str, expires_delta: timedelta = None):
    encode = {"sub" : username}
    expires = datetime.utcnow() + timedelta(minutes=20)
    encode.update({"exp": expires})

    return jwt.encode(encode, SECRET_KEY, algorithm=ALGORITHM)   

# @auth.get("/verifyToken")
# async def get_current_user(token: Annotated[str, Depends(oauth2_bearer)]):
#     try:
#         payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
#         username: str = payload.get("sub")
#         id: int = payload.get("id")
#         if username is None:
#             raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")
#         return {"username": username, "id": id}
#     except JWTError:
#         raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")

from fastapi import HTTPException, status, Depends, Request
from jose import jwt, JWTError
from typing import Optional

# ... your existing imports and code ...

async def get_token_from_cookie(request: Request) -> Optional[str]:
    # Attempt to retrieve the token from the cookie
    return request.cookies.get("token")

@auth.get("/verifyToken")
async def get_current_user(token: Optional[str] = Depends(get_token_from_cookie)):
    if not token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="No authentication token found")

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")
        return {"username": username}
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authentication credentials")