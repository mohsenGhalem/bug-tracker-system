import datetime

import jwt
import os

secretKey = os.getenv('JWT_KEY')


def generateToken(uuid: str):

    payload = {"sub": uuid, "exp": datetime.datetime.utcnow() + datetime.timedelta(days=3)}
    token = jwt.encode(payload, secretKey, algorithm="HS256")
    return token


def verifyTokenValidity(token: str) -> object:
    try:
        decoded = jwt.decode(token, secretKey, algorithms=["HS256"])
        return decoded['sub']
    except:
        return None
