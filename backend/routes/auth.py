from datetime import datetime, timedelta
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from starlette import status
from config.database import db_dependency
from models.client import Client
from passlib.context import CryptContext
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from schemas.client import ClientCreate, Client as clientSchema
from config.auth import ALGORITHM, SECRET_KEY

auth = APIRouter(
    tags=["auth"],
)


bcrypt = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_bearer = OAuth2PasswordBearer(tokenUrl="auth/token")













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

