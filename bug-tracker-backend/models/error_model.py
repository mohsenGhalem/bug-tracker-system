import uuid
from datetime import datetime

from pydantic import BaseModel


class ErrorApi(BaseModel):
    error_msg: str
    error_desc: str = None
    error_priority: int = 0
    error_status: int = 0
    error_assign: str = None
    error_reporter: str = None


class ErrorModel(ErrorApi):
    error_date: datetime = datetime.now()
