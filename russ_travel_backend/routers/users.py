from fastapi import APIRouter, HTTPException
from schemas import users
from utils import users as users_utils
from fastapi import Depends
from fastapi.security import OAuth2PasswordRequestForm


router = APIRouter()


@router.post("/sign-up", response_model=users.UserBase)
async def create_user(user: users.UserCreate):
    db_user = await users_utils.get_user_by_email(email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return await users_utils.create_user(user=user)

@router.post("/sign-in")
async def auth(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await users_utils.get_user_by_email(email=form_data.username)

    if not user:
        raise HTTPException(status_code=400, detail="Not User")

    if not users_utils.validate_password(
        password=form_data.password, hashed_password=user["hashed_password"]
    ):
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    return {"id" : user.id, "name" : user.name}

@router.post("/add-museum")
async def add_museum(label: users.LabelCreate):
    return await users_utils.add_museum(label)

@router.post("/delete-museum")
async def delete_museum(id: int, user_id: int):
    return await users_utils.delete_museum(id, user_id)

@router.get("/get-museums")
async def get_museums(user_id: int):
    return await users_utils.get_museums_by_user(user_id)

@router.post("/clear-museums")
async def clear_museums(user_id: int):
    return await users_utils.delete_all_museum(user_id)

@router.post("/add-park")
async def add_park(label: users.LabelCreate):
    return await users_utils.add_park(label)

@router.post("/delete-park")
async def delete_park(id: int, user_id: int):
    return await users_utils.delete_park(id, user_id)

@router.get("/get-parks")
async def get_parks(user_id: int):
    return await users_utils.get_park_by_user(user_id)

@router.post("/clear-parks")
async def clear_museums(user_id: int):
    return await users_utils.delete_all_park(user_id)

@router.post("/add-out")
async def add_out(label: users.LabelCreate):
    return await users_utils.add_out(label)

@router.post("/delete-out")
async def delete_out(id: int, user_id: int):
    return await users_utils.delete_out(id, user_id)

@router.get("/get-outs")
async def get_outs(user_id: int):
    return await users_utils.get_out_by_user(user_id)

@router.post("/clear-out")
async def clear_museums(user_id: int):
    return await users_utils.delete_all_out(user_id)
