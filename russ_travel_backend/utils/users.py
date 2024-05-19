import hashlib
import random
import string
from models.users import users_table
from models.labels import museums, parks, out_places
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
    return {**user.dict(), "id" : user_id}
    #return {"id" : user_id, "email" : user.email}

async def find_museum_by_id_and_user_id(id: int, user_id: int):
    query = museums.select().where(museums.c.id == id and museums.c.user_id == user_id)
    if query:
        return True
    return False
async def add_museum(lable: user_schema.LabelCreate):
    query = museums.insert().values(
        id=lable.id, user_id=lable.user_id, title=lable.title
    )
    await database.execute(query)
    return {"code" : 200}

async def delete_museum(id: int, user_id: int):
    query = museums.delete().where(((museums.c.id == id) & (museums.c.user_id == user_id)))
    await database.execute(query)
    return {"code": 200}

async def get_museums_by_user(user_id: int):
    query = museums.select().where(museums.c.user_id == user_id)
    result = await database.fetch_all(query)
    museums_list = [{"id": row['id'], "title": row['title']} for row in result]
    return museums_list

async def delete_all_museum(user_id: int):
    query = museums.delete().where(museums.c.user_id == user_id)
    await database.execute(query)
    return {"code": 200}

async def add_park(lable: user_schema.LabelCreate):
    query = parks.insert().values(
        id=lable.id, user_id=lable.user_id, title=lable.title
    )
    await database.execute(query)
    return {"code" : 200}

async def delete_park(id: int, user_id: int):
    query = parks.delete().where((parks.c.id == id) & (parks.c.user_id == user_id))
    await database.execute(query)
    return {"code": 200}

async def get_park_by_user(user_id: int):
    query = parks.select().where(parks.c.user_id == user_id)
    result = await database.fetch_all(query)
    parks_list = [{"id": row['id'], "title": row['title']} for row in result]
    return parks_list

async def delete_all_park(user_id: int):
    query = parks.delete().where(parks.c.user_id == user_id)
    await database.execute(query)
    return {"code": 200}

async def add_out(lable: user_schema.LabelCreate):
    query = out_places.insert().values(
        id=lable.id, user_id=lable.user_id, title=lable.title
    )
    await database.execute(query)
    return {"code" : 200}

async def delete_out(id: int, user_id: int):
    query = out_places.delete().where((out_places.c.id == id) & (out_places.c.user_id == user_id))
    await database.execute(query)
    return {"code": 200}

async def get_out_by_user(user_id: int):
    query = out_places.select().where(out_places.c.user_id == user_id)
    result = await database.fetch_all(query)
    outs_list = [{"id": row['id'], "title": row['title']} for row in result]
    return outs_list

async def delete_all_out(user_id: int):
    query = out_places.delete().where(out_places.c.user_id == user_id)
    await database.execute(query)
    return {"code": 200}
