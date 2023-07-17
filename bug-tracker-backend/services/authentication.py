
from models.api_response import ApiResponse
from models.user_model import AuthModel, User
from pymongo_get_database import get_database
from utils.jwt_service import generateToken


def signUp(auth_item: AuthModel) -> ApiResponse:
    dbname = get_database()
    auth_collection = dbname['authentication']

    found = auth_collection.find_one({'email': auth_item.email})

    if found is None:
        try:
            auth_data = dict(auth_item)
            auth_collection.insert_one(auth_data)
            user = User(uid=str(auth_data['_id']), name=auth_data['name'], email=auth_data['email'])
            user_json = dict(user)

            # Insert The user information on db
            users_collection = dbname['users']
            users_collection.insert_one(user_json)
            user_json['_id'] = str(user_json['_id'])
            # Generate Token
            token = generateToken(user_json['_id'])

            data = {
                'token': token,
                'info': user_json
            }

            return ApiResponse(message="SUCCESS", description="Sign up successfully", success=True,
                               status_code=200, data=data)
        except Exception as e:
            print(f'ERROR = {e}')
            data = {
                'token': None,
                'info': None
            }
            return ApiResponse(message="SERVER_ERROR", description="sorry,we are running into server error try again "
                                                                   "later", success=False, status_code=500, data=data)

    else:
        data = {
            'token': None,
            'info': None
        }
        return ApiResponse(message="ALREADY_EXISTS", description="this account already exists", success=True,
                           status_code=200, data=data)


def signIn(auth_item: AuthModel) -> ApiResponse:
    try:
        dbname = get_database()
        auth_collection = dbname['authentication']

        found = auth_collection.find_one({'email': auth_item.email})

        if found is None:
            return ApiResponse(message="NOT_FOUND", description="there is no account with such this email !",
                               success=False, status_code=404, data={})
        else:
            password = found['password']
            if password != auth_item.password:
                return ApiResponse(message="PASSWORD_INVALID", description="Password incorrect!", success=True,
                                   status_code=200, data={})
            else:
                users_collection = dbname['users']

                user = users_collection.find_one({'uid': str(found['_id'])})

                token = generateToken(str(found['_id']))
                del user['_id']
                data = {'token': token, 'info': dict(user)}
                return ApiResponse(message="SUCCESS", description="Sign in successfully", success=True,
                                   status_code=200, data=data)

    except Exception as e:

        print(f'ERROR = {e}')

        return ApiResponse(message="SERVER_ERROR", description="we running into server error try again later",
                           success=False, status_code=500)
