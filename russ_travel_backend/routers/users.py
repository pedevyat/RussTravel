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