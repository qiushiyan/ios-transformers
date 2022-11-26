import uuid

from firebase_admin import firestore

from src.firebase import db

data = [
    {"text": "I am a ML/AI language model tutor", "received": True},
    {"text": "What is a language model?", "received": False},
    {
        "text": "A language model is a statistical model that describes the probability of a word given the previous words.",
        "received": True,
    },
]

for doc in data:
    doc["id"] = str(uuid.uuid4())
    doc["timestamp"] = firestore.SERVER_TIMESTAMP
    db.collection("messages").document().set(doc)
