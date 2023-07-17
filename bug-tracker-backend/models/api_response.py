from pydantic import BaseModel


class ApiResponse(BaseModel):
    message: str
    description: str = None
    success: bool
    status_code: int
    data: dict = {}
