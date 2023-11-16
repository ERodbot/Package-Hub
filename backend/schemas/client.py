from pydantic import BaseModel, EmailStr
from fastapi import Form
from typing import Annotated


class Client(BaseModel):
    name: Annotated[str, Form()]
    lastname: Annotated[str, Form()]
    username: Annotated[str, Form()]
    telephone: Annotated[str, Form()]
    email: Annotated[EmailStr, Form()]
    country: Annotated[str, Form()]
    state: Annotated[str, Form()]
    city: Annotated[str, Form()]
    street: Annotated[str, Form()]


class ClientCreate(Client):
    password: Annotated[str, Form()]
    postal_code: Annotated[str, Form()]

class ClientLogin(BaseModel):
    username: Annotated[str, Form()]
    password: Annotated[str, Form()]

class test(BaseModel):
    address: str
    postal_code: int
