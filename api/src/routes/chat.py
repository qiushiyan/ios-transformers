from time import time

from fastapi import APIRouter

from src.firebase import db
from src.services import MessageService
from src.utils import get_prefix

chat_router = APIRouter()
message_service = MessageService(db)


@chat_router.post("/")
def gpt3_reply():
    all_messages = message_service.messages
    all_messages = list(
        map(
            lambda message: get_prefix(message["received"]) + " " + message["text"],
            all_messages,
        )
    )
    prompt = "\n".join(all_messages)
    reply = message_service.reply(prompt)
    message_service.add_message(text=reply, received=True)
    return {"text": reply}


@chat_router.get("/")
def list_messages():
    messages = message_service.get_messages()
    return messages
