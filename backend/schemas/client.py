from typing import Optional
from pydantic import BaseModel, EmailStr, constr


class Client(BaseModel):
    username: str
    name: str
    lastname: str
    email: str
    telephone: str
    password: str

class ClientCreate(Client):
    pass

class Client(Client):
    id: int

    class Config:
        orm_mode = True