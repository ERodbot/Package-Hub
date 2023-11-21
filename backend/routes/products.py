import base64
from fastapi import APIRouter, HTTPException, status
from config.database import db_dependency
from schemas.client import Client, ClientCreate, test
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError

product = APIRouter(tags=["Product"])

@product.get("/getAllInventoryProducts")
def getAllInventoryProducts(db: db_dependency):
    query = text("""EXEC GetAllInventoryProducts""")
    try:
        result = db.execute(query).fetchall()

        # Make the dictionary to return
        result_dict = []
        for row in result:
            result_dict.append({
                'producto': row[0],
                'descripcion': row[1],
                'marca': row[2],
                'inventario': row[3],
                'cantidad': row[4],
                'precio': row[5],
                'bodega': row[6]
            })

    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
    return result_dict
    
    
    

@product.get("/getProduct/{category}")
def getProductPerCategory(category: str, db: db_dependency):
    # Llama al procedimiento almacenado en la base de datos
    query = text("""SELECT idCategory FROM [na-inventory].[inventory].[dbo].Category WHERE name = :category""")
    params = {"category": category}

    try:
        result = db.execute(query, params).fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Category not found")
        else:
            idCategory = result[0]
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    


    query = text("""EXEC GetProductsByCategory @categoryId=:category""")
    params = {"category": idCategory}

    
    try:
        result = db.execute(query, params).fetchall()
        if result is None:
            raise HTTPException(status_code=404, detail="Products not found")

        products = []
        for row in result:
            product = {
                "name": row.ProductName,
                "price": row.price,
                "image": base64.b64encode(row.ImagePath).decode() if row.ImagePath else None,
            }
            products.append(product)
        
        return products
    
    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=500, detail=error_message)
    
@product.get("/getProductDetails/{name}")
def getProductDetails(name: str, db: db_dependency):
    # Llama al procedimiento almacenado en la base de datos
    query = text("""EXEC GetProductDetails @productName=:name""")
    params = {"name": name}

    try:
        result = db.execute(query, params).fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Product not found")
        else:
            product = {
                "name": result.ProductName,
                "description": result.Description,
                "brand": result.Brand,
                "color": result.Color,
                "material": result.Material,
                "weight": result.Weight,
                "price": result.UnitPrice,
                "imageName": result.ImageName,
                "image": base64.b64encode(result.ImagePath).decode() if result.ImagePath else None
            }
        
        return product
    
    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=500, detail=error_message)

@product.get("/getProductImages/{name}")
def getProductImages(name: str, db: db_dependency):
    # Llama al procedimiento almacenado en la base de datos
    query = text("""EXEC GetProductImages @productName=:name""")
    params = {"name": name}

    try:
        result = db.execute(query, params).fetchall()
        if result is None:
            raise HTTPException(status_code=404, detail="Product not found")

        images = []
        for row in result:
            image = {
                "imageName": row.ImageName,
                "image": base64.b64encode(row.ImagePath).decode() if row.ImagePath else None
            }
            images.append(image)
        
        return images
    
    except DBAPIError as e:
        error_message = e.args[0]
        raise HTTPException(status_code=500, detail=error_message)