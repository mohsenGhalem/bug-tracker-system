import os
from dotenv import load_dotenv
from pymongo import MongoClient


def get_database():
    load_dotenv()

    password = os.getenv('PASSWORD')
    user = os.getenv('USER')

    connection_string = f"mongodb+srv://{user}:{password}@bugtracker.vebjlre.mongodb.net/?retryWrites" \
                        f"=true&w" \
                        "=majority"

    local_connection_string = 'mongodb://localhost:32769/'

    client = MongoClient(local_connection_string)

    return client['bug_tracker_db']
