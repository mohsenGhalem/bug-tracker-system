from pydantic import BaseModel


class User(BaseModel):
    uid: str = ''
    name: str
    email: str
    role: str = ''
    imgPath: str = ''
    isReporter: bool = False


class AuthModel(BaseModel):
    email: str
    password: str
    name: str = None
