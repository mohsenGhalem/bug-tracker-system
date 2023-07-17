from bson import ObjectId
from fastapi import HTTPException

from models.api_response import ApiResponse
from models.test_model import TestModel
from pymongo_get_database import get_database


def getTests():
    try:
        db_name = get_database()
        collection = db_name['tests']

        data = collection.find()
        json_data: list = list(data)
        for item in json_data:
            item["_id"] = str(item["_id"])

        test_data = {
            'info': json_data
        }

        response = ApiResponse(message="SUCCESS", description="",
                               success=False, status_code=200, data=test_data)

        return response
    except Exception as error:
        print(f"ERROR = {error}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


def updateTest(test_item: TestModel, test_id: str = None):
    try:
        if test_id is None:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=404, detail=dict(response))
        else:
            db_name = get_database()
            collection = db_name['tests']
            updated = collection.update_one({'_id': ObjectId(test_id)}, {"$set": dict(test_item)})
            if updated.matched_count == 1:
                return ApiResponse(message="SUCCESS", description="item updated"
                                   , success=True, status_code=200, data={})
            else:
                response = ApiResponse(message="NOT_FOUND", description="item not found",
                                       success=False, status_code=404, data={})
                raise HTTPException(status_code=404, detail=dict(response))

    except Exception as error:
        print(f"ERROR = {error}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        return response


def deleteTest(test_id: str = None):
    try:
        if test_id is None:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=404, detail=dict(response))
        else:
            db_name = get_database()
            collection = db_name['tests']
            deleted = collection.delete_one({'_id': ObjectId(test_id)})
            if deleted.deleted_count == 1:
                return ApiResponse(message="SUCCESS", description="item deleted"
                                   , success=True, status_code=200, data={})
            else:
                response = ApiResponse(message="NOT_FOUND", description="item not found",
                                       success=False, status_code=404, data={})
                return response

    except Exception as error:
        print(f"ERROR = {error}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


def createTest(test_item: TestModel):
    try:
        if test_item is None:
            response = ApiResponse(message="NEED_INFORMATION", description="need more details",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=400, detail=dict(response))
        else:
            db_name = get_database()
            error_collection = db_name['tests']

            data = dict(test_item)
            error_collection.insert_one(data)
            data['_id'] = str(data['_id'])
            return ApiResponse(message="SUCCESS", description="item added", success=True, status_code=200,
                               data={'info': data})

    except Exception as error:
        print(f"ERROR = {error}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))
