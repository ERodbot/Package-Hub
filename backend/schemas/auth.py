from typing import Optional
from pydantic import BaseModel, EmailStr, constr

class CreateUserRequest(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str