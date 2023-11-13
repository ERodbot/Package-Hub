from fastapi import APIRouter, HTTPException
from schemas.client import Client as clientSchema
from sqlalchemy.orm import Session
from config.database import db_dependency
from models.client import Client
from schemas.client import ClientCreate, Client as clientSchema
from sqlalchemy import text


client = APIRouter()
    
@client.get("/getClient/{id}", response_model = clientSchema)
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