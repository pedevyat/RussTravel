
from pydantic import UUID4, BaseModel, EmailStr, Field, validator

class UserCreate(BaseModel):
    """ Проверяет sign-up запрос """
    email: EmailStr
    name: str
    password: str

class UserBase(BaseModel):
    """ Формирует тело ответа с деталями пользователя """
    id: int
    email: EmailStr
    name: str

