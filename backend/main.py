from fastapi import FastAPI
from config.database import engine, Base
from fastapi.middleware.cors import CORSMiddleware
from routes.client import client
from routes.auth import auth

app = FastAPI()
app.include_router(client)
app.include_router(auth)

origins = [
    "http://localhost:8000",
    "http://localhost:5173"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)


Base.metadata.create_all(bind=engine)