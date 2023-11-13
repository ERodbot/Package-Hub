from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

username = "sa"
password = "12345"
server = "localhost"
port = "1433"
db = "xd"
driver = "ODBC Driver 17 for SQL Server"

URL_DATABASE = f"mssql+pyodbc://{username}:{password}@{server}:{port}/{db}?driver={driver}"

engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()