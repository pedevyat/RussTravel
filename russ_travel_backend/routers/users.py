from fastapi import APIRouter, HTTPException
from schemas import users
from utils import users as users_utils


router = APIRouter()


@router.post("/sign-up", response_model=users.UserBase)
async def create_user(user: users.UserCreate):
    db_user = await users_utils.get_user_by_email(email=user.email)
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    return await users_utils.create_user(user=user)