from fastapi import FastAPI

app = FastAPI(title="RussTravel")

@app.get("/users")
def get_user():
    return {"user"}
