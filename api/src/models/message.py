from pydantic import BaseModel


class Message(BaseModel):
    id: str
    text: str
    received: bool
    timestamp: str
