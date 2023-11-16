from pydantic import BaseModel, EmailStr


class Client(BaseModel):
    name: str
    lastname: str
    username: str
    telephone: str
    email: EmailStr
    country: str
    state: str
    city: str
    street: str


class ClientCreate(Client):
    password: str
    postal_code: int

class ClientLogin(BaseModel):
    username: str
    password: str

class test(BaseModel):
    address: str
    postal_code: int
