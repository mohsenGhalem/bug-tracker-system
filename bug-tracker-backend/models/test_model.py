from pydantic import BaseModel


class TestModel(BaseModel):
    error_id: str
    tests: list[dict] = None
    test_status: bool = False
    uid: str
