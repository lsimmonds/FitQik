FitQik
======

FitQik

# Create new user
## Url
http://localhost:3000/api/users/
##Method
POST
##Header
Content-type: application/json

## JSON Input

{
    "api_user": {
        "email": "test3@leonsimmonds.com",
        "password": "testing123",
        "password_confirmation": "testing123"
    }
}

## JSON Return String

{
   "id": 1,
   "created_at": "2014-01-13T06:47:16.724Z",
   "updated_at": "2014-01-13T06:47:16.733Z",
   "creator_id": null,
   "updater_id": null,
   "email": "test3@leonsimmonds.com"
}


#Sign In

## Url
http://localhost:3000/api/users/sign_in
##Method
POST
##Header
Content-type: application/json

## JSON Input
{
    "api_user": {
        "email": "test3@leonsimmonds.com",
        "password": "testing123"
    }
}

## JSON Return String
{
  "token": "-zkz8VtDTp2Rkt4mg8mL",
  "email": "test3@leonsimmonds.com"
}


