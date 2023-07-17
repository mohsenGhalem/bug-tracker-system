import fastapi.responses
from fastapi import FastAPI, Header, HTTPException, File, UploadFile
from fastapi.staticfiles import StaticFiles

from models.api_response import ApiResponse
from models.deploy_model import DeployModel
from models.error_model import ErrorModel, ErrorApi
from models.test_model import TestModel
from models.user_model import AuthModel, User
import services.authentication as au
from services import error_service, test_service, deploy_service, user_service

from utils.jwt_service import verifyTokenValidity

app = FastAPI()


# Authentication
@app.post("/signIn", response_model=ApiResponse)
def login(auth: AuthModel):
    response = au.signIn(auth)
    return response


@app.post("/signUp", response_model=ApiResponse)
def signup(auth: AuthModel):
    response = au.signUp(auth)
    return response


# Error Endpoint

@app.get("/errors/", response_model=ApiResponse)
def getErrors(token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return error_service.getError()


@app.post("/errors/", response_model=ApiResponse)
def addError(error_item: ErrorApi, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        try:
            return error_service.createError(error_item=error_item)
        except Exception as e:
            print(f'Error = {e}')
            response = ApiResponse(message="SERVER_ERROR",
                                   description="sorry,we are running into server error try again "
                                               "later", success=False, status_code=500, data={})
            raise HTTPException(status_code=500, detail=dict(response))


@app.patch("/errors/{error_id}", response_model=ApiResponse)
def modifyErr(error_id: str, error_item: ErrorModel, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return error_service.updateError(error_id=error_id, error_item=error_item)


@app.delete("/errors/{error_id}", response_model=ApiResponse)
def deleteErr(error_id: str, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return error_service.deleteError(error_id=error_id)


# Test Endpoint

@app.get("/tests/", response_model=ApiResponse)
def getTests(token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return test_service.getTests()


@app.post("/tests/", response_model=ApiResponse)
def addTest(test_item: TestModel, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return test_service.createTest(test_item=test_item)


@app.patch("/tests/{test_id}", response_model=ApiResponse)
def modifyTest(test_id: str, test_item: TestModel, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return test_service.updateTest(test_id=test_id, test_item=test_item)


@app.delete("/tests/{test_id}", response_model=ApiResponse)
def deleteTests(test_id: str, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return test_service.deleteTest(test_id=test_id)


# Deploy Endpoint
@app.get("/deploys/", response_model=ApiResponse)
def getDeploys(token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return deploy_service.getDeploys()


@app.post("/deploys/", response_model=ApiResponse)
def addDeploy(deploy_item: DeployModel, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return deploy_service.createDeploy(deploy_item_item=deploy_item)


@app.patch("/deploys/{deploy_id}", response_model=ApiResponse)
def modifyDeploy(deploy_id: str, deploy_item: DeployModel, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return deploy_service.updateDeploy(deploy_id=deploy_id, deploy_item=deploy_item)


@app.delete("/deploys/{deploy_id}", response_model=ApiResponse)
def deleteDeploy(deploy_id: str, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return deploy_service.deleteDeploy(deploy_id=deploy_id)


# USER Endpoint
@app.post("/users/upload/")
async def upload_image(file: UploadFile = File(...), token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return await user_service.upload_image(file=file,uid=uid)


@app.get("/users/")
def read_users(query: str = "", token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return user_service.queryUsers(query=query)


@app.patch("users/{user_id}")
def update_user_info(user: User,user_id: str, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        user_service.updateUserInfo(user, user_id)


@app.patch("auth/{uid}")
def update_user_auth(auth: AuthModel, uid: str, token: str = Header(...)):
    uid = verifyTokenValidity(token)

    if uid is None:
        data = {
            'token': None,
            'info': None
        }
        response = ApiResponse(message="UNAUTHORIZED",
                               description="you don't have authorization to access this content",
                               success=True,
                               status_code=401, data=data)
        response_json = dict(response)
        raise HTTPException(status_code=401, detail=response_json)

    else:
        return user_service.updateUserAuth(auth, uid)


app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")