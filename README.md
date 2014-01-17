FitQik
======

FitQik

# Users
## Create new user
### Url
http://localhost:3000/api/users/
###Method
POST
###Header
Content-type: application/json
### JSON Input
{
    "api_user": {
        "email": "test3@leonsimmonds.com",
        "password": "testing123",
        "password_confirmation": "testing123"
    }
}
### JSON Return String
#### success
{
   "id": 1,
   "created_at": "2014-01-13T06:47:16.724Z",
   "updated_at": "2014-01-13T06:47:16.733Z",
   "creator_id": null,
   "updater_id": null,
   "email": "test3@leonsimmonds.com"
}
#### error
{
    "errors": {
        "email": [
            "has already been taken"
        ]
    }
}
##Sign In
### Url
http://localhost:3000/api/users/sign_in
###Method
POST
###Header
Content-type: application/json
### JSON Input
{
    "api_user": {
        "email": "test3@leonsimmonds.com",
        "password": "testing123"
    }
}
### JSON Return String
{
  "token": "-zkz8VtDTp2Rkt4mg8mL",
  "email": "test3@leonsimmonds.com"
}

#Students
##Fetch All Students (that you are allowed to see)
### Url
http://localhost:3000/api/students?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
###Method
GET
###Header
Content-type: application/json
### GET query string
token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
### JSON Return String
[
  {
    "id": 1,
    "user_id": 2,
    "name": "A test student lalala",
    "created_at": "2014-01-16T07:51:25.430Z",
    "updated_at": "2014-01-16T07:51:25.430Z"
  },
  {
    "id": 2,
    "user_id": 2,
    "name": "A test student lalala",
    "created_at": "2014-01-16T07:56:03.013Z",
    "updated_at": "2014-01-16T07:56:03.013Z"
  },
  {
    "id": 3,
    "user_id": 2,
    "name": "A test student lalala",
    "created_at": "2014-01-16T07:57:09.312Z",
    "updated_at": "2014-01-16T07:57:09.312Z"
  },
  {
    "id": 4,
    "user_id": 2,
    "name": "A test student lalala",
    "created_at": "2014-01-16T07:58:39.609Z",
    "updated_at": "2014-01-16T07:58:39.609Z"
  }
]
##Create A Student
### Url    
http://localhost:3000/api/students
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "student": {
        "name": "A test student lalala"
    },
    "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 4,
  "user_id": 2,
  "name": "A test student lalala",
  "created_at": "2014-01-16T07:58:39.609Z",
  "updated_at": "2014-01-16T07:58:39.609Z"
}
##Fetch A Student
### Url    
http://localhost:3000/api/students/2?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
###Method    
GET
###Header
Content-type: application/json

### GET Query String
token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com

### JSON Return String
{
  "id": 2,
  "user_id": 2,
  "name": "A test student lalala",
  "created_at": "2014-01-16T07:56:03.013Z",
  "updated_at": "2014-01-16T07:56:03.013Z"
}
##Update A Student
### Url    
http://localhost:3000/api/students/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
     "student": {
        "name": "A New Name"
    },
   "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 2,
  "user_id": 2,
  "name": "A New Name",
  "created_at": "2014-01-16T07:56:03.013Z",
  "updated_at": "2014-01-16T08:11:33.100Z"
}
##Delete A Student
### Url    
http://localhost:3000/api/students/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
     "student": {
        "name": "A New Name"
    },
   "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String

