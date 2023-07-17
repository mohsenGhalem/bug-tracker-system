from datetime import datetime

from pydantic import BaseModel


class DeployModel(BaseModel):
    deploy_date: datetime = datetime.now()
    error_id: str
    