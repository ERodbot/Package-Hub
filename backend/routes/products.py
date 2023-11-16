from fastapi import APIRouter, HTTPException, status
from config.database import db_dependency
from schemas.client import Client, ClientCreate, test
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError


product = APIRouter()

@product.get("/getProduct/{category}")
def getProductPerCategory(category: str, db: db_dependency):
    # Llama al procedimiento almacenado en la base de datos
    query = text("""SELECT idCategory FROM Category WHERE name = :category""")
    params = {"category": category}
    


    query = "EXEC ObtenerProductosPorCategoria @Categoria=:category"
    params = {"category": category}
    
    try:
        products = db.execute(query, params).fetchall()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    if products is None:
        raise HTTPException(status_code=404, detail="Products not found")

    return products