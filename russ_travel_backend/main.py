from os import environ
from fastapi import FastAPI
from sqlalchemy import *
from models.users import users_table
from routers import users as users_router
from models.database import database

app = FastAPI()
app.include_router(users_router.router)

@app.on_event("startup")
async def startup():
    # когда приложение запускается устанавливаем соединение с БД
    await database.connect()


@app.on_event("shutdown")
async def shutdown():
    # когда приложение останавливается разрываем соединение с БД
    await database.disconnect()


@app.get("/")
async def read_root():
    # изменим роут таким образом, чтобы он брал данные из БД
    query = (
        select(users_table)
    )
    return await database.fetch_all(query)