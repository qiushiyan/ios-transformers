def get_prefix(received: bool) -> str:
    if received:
        return "ML Tutor:"
    else:
        return "You:"
