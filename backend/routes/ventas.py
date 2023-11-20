from fastapi import APIRouter, HTTPException, status
from config.database import db_dependency
from schemas.client import Client, ClientCreate, test
from sqlalchemy import text
from sqlalchemy.exc import DBAPIError


ventas = APIRouter(
    tags=["ventas"],
)

@ventas.post("/createOrder")
def registerVenta(db: db_dependency, email: str, totalPrice: float, payType: str):
    query = text("""EXEC createOrder @email=:email, @totalPrice=:totalPrice, @payType=:payType""")
    params = {
        'email': email,
        'totalPrice': totalPrice,
        'payType': payType
    }

    try:
        order = db.execute(query, params).fetchone()
        return order[0]
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)
    
@ventas.post("/createOrderDetail")
def registerVentaDetail(db: db_dependency, idOrder: int, idProduct: int, quantity: int):
    query = text("""EXEC createOrderDetail @idOrder=:idOrder, @idProduct=:idProduct, @quantity=:quantity""")
    params = {
        'idOrder': idOrder,
        'idProduct': idProduct,
        'quantity': quantity
    }

    try:
        orderDetail = db.execute(query, params)
        return orderDetail
    except DBAPIError as e:
        error_message = e.args[0]
        return HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE, detail=error_message)