from pydantic import BaseModel, EmailStr
from fastapi import Form
from typing import Annotated

class Employee(BaseModel):
    username: Annotated[str, Form()]
    name: Annotated[str, Form()]
    lastname: Annotated[str, Form()]
    email: Annotated[EmailStr, Form()]
    phone: Annotated[str, Form()]
    password: Annotated[str, Form()]
    country: Annotated[str, Form()]
    state: Annotated[str, Form()]
    city: Annotated[str, Form()]
    street: Annotated[str, Form()]
    postal_code: Annotated[str, Form()]
    rol: Annotated[str, Form()]
