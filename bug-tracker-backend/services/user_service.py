from bson import ObjectId
from fastapi import HTTPException, File

from models.api_response import ApiResponse
from models.user_model import User, AuthModel
from pymongo_get_database import get_database


def queryUsers(query: str):
    try:
        db_name = get_database()
        user_collection = db_name['users']

        data = user_collection.find({"email": {"$regex": f"^{query}"}})
        json_data: list = list(data)
        for item in json_data:
            item["_id"] = str(item["_id"])
        users_data = {
            'info': json_data
        }
        response = ApiResponse(message="SUCCESS", description="", success=False, status_code=200, data=users_data)

        return response
    except Exception as e:
        print(f"ERROR = {e}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


def updateUserInfo(user: User, uid: str):
    try:
        db_name = get_database()
        user_collection = db_name['users']

        updated = user_collection.update_one({'_id': ObjectId(uid)}, {"$set": dict(user)})
        if updated.matched_count == 1:
            return ApiResponse(message="SUCCESS", description="item updated", success=True, status_code=200,
                               data={})
        else:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            return response

    except Exception as e:
        print(f"ERROR = {e}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


def updateUserAuth(auth: AuthModel, uid: str):
    try:
        db_name = get_database()
        user_collection = db_name['users']
        auth_collection = db_name['authentication']
        updated1 = auth_collection.update_one({'_id': ObjectId(uid)}, {"$set": dict(auth)})
        updated2 = user_collection.update_one({'_id': ObjectId(uid)}, {"$set": {'email': auth.email}})
        if updated2.matched_count == 1 and updated1.matched_count == 1:
            return ApiResponse(message="SUCCESS", description="item updated", success=True, status_code=200,
                               data={})
        else:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            return response

    except Exception as e:
        print(f"ERROR = {e}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


async def upload_image(file: File(), uid: str):
    try:
        file_path = f"uploads/{file.filename}"
        with open(file_path, "wb") as f:
            f.write(await file.read())

        db_name = get_database()
        user_collection = db_name['users']
        updated = user_collection.update_one({'_id': ObjectId(uid)}, {"$set": {'imgPath': file_path}})
        if updated.matched_count == 1:
            return ApiResponse(message="SUCCESS", description="image uploaded", success=True, status_code=200,
                               data={})
        else:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            return response

    except Exception as e:
        print(f"ERROR = {e}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))
