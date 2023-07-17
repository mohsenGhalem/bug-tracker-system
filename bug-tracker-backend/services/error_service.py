from datetime import datetime

from bson import ObjectId
from fastapi import HTTPException

from models.api_response import ApiResponse
from models.error_model import ErrorModel, ErrorApi
from pymongo_get_database import get_database


def getError() -> ApiResponse:
    try:
        db_name = get_database()
        error_collection = db_name['errors']

        data = error_collection.find()
        print(1)
        json_data: list = list(data)
        for item in json_data:
            item["_id"] = str(item["_id"])

        error_data = {
            'info': json_data
        }

        response = ApiResponse(message="SUCCESS", description="",
                               success=False, status_code=200, data=error_data)

        return response
    except Exception as e:
        print(f"ERROR = {e}")
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))


def updateError(error_item: ErrorModel, error_id: str = None) -> ApiResponse:
    try:
        if error_id is None:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=404, detail=dict(response))
        else:
            db_name = get_database()
            error_collection = db_name['errors']
            updated = error_collection.update_one({'_id': ObjectId(error_id)}, {"$set": dict(error_item)})
            if updated.matched_count == 1:
                return ApiResponse(message="SUCCESS", description="item updated", success=True, status_code=200,
                                   data={})
            else:
                response = ApiResponse(message="NOT_FOUND", description="item not found",
                                       success=False, status_code=404, data={})
                return response

    except Exception as e:
        print(f'ERROR = {e}')

        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "

                                                                   "later", success=False, status_code=500, data={})

        raise HTTPException(status_code=500, detail=dict(response))


def createError(error_item: ErrorApi) -> ApiResponse:
    try:
        if error_item is None:
            response = ApiResponse(message="NEED_INFORMATION", description="need more details",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=400, detail=dict(response))
        else:
            db_name = get_database()
            error_collection = db_name['errors']
            error_model_item = ErrorModel(error_date=datetime.now(),
                                          error_msg=error_item.error_msg, error_desc=error_item.error_desc,
                                          error_priority=error_item.error_priority,
                                          error_status=error_item.error_status,
                                          error_assign=error_item.error_assign,
                                          error_reporter=error_item.error_reporter)
            data = dict(error_model_item)
            error_collection.insert_one(data)
            data['_id'] = str(data['_id'])

            error_data = {
                "info": data
            }

            return ApiResponse(message="SUCCESS", description="item added", success=True, status_code=200,
                               data=error_data)

    except HTTPException as httpException:

        raise httpException


def deleteError(error_id: str = None) -> ApiResponse:
    try:
        if error_id is None:
            response = ApiResponse(message="NOT_FOUND", description="item not found",
                                   success=False, status_code=404, data={})
            raise HTTPException(status_code=404, detail=dict(response))
        else:
            db_name = get_database()
            error_collection = db_name['errors']
            deleted = error_collection.delete_one({'_id': ObjectId(error_id)})
            if deleted.deleted_count == 1:
                return ApiResponse(message="SUCCESS", description="item deleted", success=True, status_code=200,
                                   data={})
            else:
                response = ApiResponse(message="NOT_FOUND", description="item not found",
                                       success=False, status_code=404, data={})
                return response

    except Exception as e:

        print(f'ERROR = {e}')
        response = ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data={})
        raise HTTPException(status_code=500, detail=dict(response))
