import hashlib
import random
import string
from models.users import users_table
from schemas import users as user_schema
from models.database import database

def get_random_string(length=12):
    """ Генерирует случайную строку, использующуюся как соль """
    return "".join(random.choice(string.ascii_letters) for _ in range(length))

def hash_password(password: str, salt: str = None):
    """ Хеширует пароль с солью """
    if salt is None:
        salt = get_random_string()
    enc = hashlib.pbkdf2_hmac("sha256", password.encode(), salt.encode(), 100_000)
    return enc.hex()
def validate_password(password: str, hashed_password: str):
    return password == hashed_password

async def get_user_by_email(email: str):
    """ Возвращает информацию о пользователе """
    query = users_table.select().where(users_table.c.email == email)
    return await database.fetch_one(query)

async def create_user(user: user_schema.UserCreate):
    """ Создает нового пользователя в БД """
    query = users_table.insert().values(
        email=user.email, name=user.name, hashed_password=user.password
    )
    user_id = await database.execute(query)

    return {**user.dict(), "id": user_id}