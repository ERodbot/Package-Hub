from sqlalchemy import Column, Integer, String, Boolean
from config.database import Base


class Client(Base):
    __tablename__ = 'client'

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, index=True)
    name = Column(String)
    lastname = Column(String)
    email = Column(String(255), unique=True, index=True)
    telephone = Column(String)
    password = Column(String)