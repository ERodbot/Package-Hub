from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm.session import Session
from typing import Annotated
from fastapi import Depends

# Credentials for database
username = "sa"
password = "12345"
server = "localhost"
port = "1433"
db = "cluster"
driver = "ODBC Driver 17 for SQL Server"

# Create connection string
URL_DATABASE = f"mssql+pyodbc://{username}:{password}@{server}:{port}/{db}?driver={driver}"

# Create engine
engine = create_engine(URL_DATABASE)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency for database
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


db_dependency = Annotated[Session, Depends(get_db)]
Base = declarative_base()