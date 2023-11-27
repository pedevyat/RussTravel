from fastapi import FastAPI
from models.users import users_table
import databases

database = databases.Database("k")

app = FastAPI(title="RussTravel")


@app.on_event("startup")
async def startup():
    await database.connect()
    
@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.get("/")
async def read_root():
    return await database.fetch_all("SELECT * FROM users");
    
@app.post("/users")
async def create_user(username: str, email_addr: str, password: str):
    query = "INSERT INTO users (name, email, hashed_password) VALUES (:username, :email_addr, :password)"
    values = {"username": username, "email_addr": email_addr, "password": password}
    await database.execute(query=query, values=values)
    return {"message": "User created successfully"}

	
