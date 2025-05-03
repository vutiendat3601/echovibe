import random

IDENTITY_FIRST_CHARACTERS = "abcdefghijklmnopqrstuvwxyz"
IDENTITY_CHARACTERS = (
    "abcdefghijklmnopqrstuvwxyz"
    "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789"
    "abcdefghijklmnopqrstuvwxyz"
)
AGGREGATE_ID_LENGTH = 12

def generate_aggregate_id():
    aggregate_id = [
        random.choice(IDENTITY_FIRST_CHARACTERS)
    ]
    aggregate_id += [
        random.choice(IDENTITY_CHARACTERS)
        for _ in range(1, AGGREGATE_ID_LENGTH)
    ]
    return ''.join(aggregate_id)
