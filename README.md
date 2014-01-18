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
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String

#Teachers
##Fetch All Teachers (that you are allowed to see)
### Url
http://localhost:3000/api/teachers?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
    "name": "A test teacher lalala",
    "created_at": "2014-01-16T07:51:25.430Z",
    "updated_at": "2014-01-16T07:51:25.430Z"
  },
  {
    "id": 2,
    "user_id": 2,
    "name": "A test teacher lalala",
    "created_at": "2014-01-16T07:56:03.013Z",
    "updated_at": "2014-01-16T07:56:03.013Z"
  },
  {
    "id": 3,
    "user_id": 2,
    "name": "A test teacher lalala",
    "created_at": "2014-01-16T07:57:09.312Z",
    "updated_at": "2014-01-16T07:57:09.312Z"
  },
  {
    "id": 4,
    "user_id": 2,
    "name": "A test teacher lalala",
    "created_at": "2014-01-16T07:58:39.609Z",
    "updated_at": "2014-01-16T07:58:39.609Z"
  }
]
##Create A Teacher
### Url    
http://localhost:3000/api/teachers
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "teacher": {
        "name": "A test teacher lalala"
    },
    "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 4,
  "user_id": 2,
  "name": "A test teacher lalala",
  "created_at": "2014-01-16T07:58:39.609Z",
  "updated_at": "2014-01-16T07:58:39.609Z"
}
##Fetch A Teacher
### Url    
http://localhost:3000/api/teachers/2?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
  "name": "A test teacher lalala",
  "created_at": "2014-01-16T07:56:03.013Z",
  "updated_at": "2014-01-16T07:56:03.013Z"
}
##Update A Teacher
### Url    
http://localhost:3000/api/teachers/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
     "teacher": {
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
##Delete A Teacher
### Url    
http://localhost:3000/api/teachers/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String

#Admins
##Fetch All Admins (that you are allowed to see)
### Url
http://localhost:3000/api/admins?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
    "name": "A test admin lalala",
    "created_at": "2014-01-16T07:51:25.430Z",
    "updated_at": "2014-01-16T07:51:25.430Z"
  },
  {
    "id": 2,
    "user_id": 2,
    "name": "A test admin lalala",
    "created_at": "2014-01-16T07:56:03.013Z",
    "updated_at": "2014-01-16T07:56:03.013Z"
  },
  {
    "id": 3,
    "user_id": 2,
    "name": "A test admin lalala",
    "created_at": "2014-01-16T07:57:09.312Z",
    "updated_at": "2014-01-16T07:57:09.312Z"
  },
  {
    "id": 4,
    "user_id": 2,
    "name": "A test admin lalala",
    "created_at": "2014-01-16T07:58:39.609Z",
    "updated_at": "2014-01-16T07:58:39.609Z"
  }
]
##Create An Admin
### Url    
http://localhost:3000/api/admins
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "admin": {
        "name": "A test admin lalala"
    },
    "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 4,
  "user_id": 2,
  "name": "A test admin lalala",
  "created_at": "2014-01-16T07:58:39.609Z",
  "updated_at": "2014-01-16T07:58:39.609Z"
}
##Fetch An Admin
### Url    
http://localhost:3000/api/admins/2?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
  "name": "A test admin lalala",
  "created_at": "2014-01-16T07:56:03.013Z",
  "updated_at": "2014-01-16T07:56:03.013Z"
}
##Update An Admin
### Url    
http://localhost:3000/api/admins/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
     "admin": {
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
##Delete An Admin
### Url    
http://localhost:3000/api/admins/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String

#Disciplines
##Fetch All Disciplines
### Url
http://localhost:3000/api/disciplines?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
    "name": "Butterfly Painting",
    "description": null,
    "created_at": "2014-01-18T00:09:17.965Z",
    "updated_at": "2014-01-18T00:09:17.965Z"
  },
  {
    "id": 2,
    "name": "Yoga",
    "description": null,
    "created_at": "2014-01-18T00:09:29.983Z",
    "updated_at": "2014-01-18T00:09:29.983Z"
  },
  {
    "id": 3,
    "name": "Weight Training",
    "description": null,
    "created_at": "2014-01-18T00:09:48.589Z",
    "updated_at": "2014-01-18T00:09:48.589Z"
  }
]
##Create A Discipline
### Url    
http://localhost:3000/api/disciplines
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "discipline": {
        "name": "Yoga"
    },
    "token": "rAoj17gAdDJEudZ8D7yF",
    "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 4,
  "user_id": 2,
  "name": "Yoga",
  "created_at": "2014-01-16T07:58:39.609Z",
  "updated_at": "2014-01-16T07:58:39.609Z"
}
##Fetch A Discipline
### Url    
http://localhost:3000/api/disciplines/2?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
  "name": "A test discipline lalala",
  "created_at": "2014-01-16T07:56:03.013Z",
  "updated_at": "2014-01-16T07:56:03.013Z"
}
##Update A Discipline
### Url    
http://localhost:3000/api/disciplines/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
     "discipline": {
        "name": "Tarot Reading"
    },
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
{
  "id": 1,
  "name": "Tarot Reading",
  "description": null,
  "created_at": "2014-01-18T00:09:17.965Z",
  "updated_at": "2014-01-18T00:14:27.459Z"
}
##Delete A Discipline
### Url    
http://localhost:3000/api/disciplines/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String

#Subjects
##Fetch All Subjects
### Url
http://localhost:3000/api/subjects?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
    "discipline_id": 1,
    "name": "How to Cheat Fate",
    "description": "The Cards Don't Lie Maaaaaaaaaan",
    "created_at": "2014-01-18T05:06:27.372Z",
    "updated_at": "2014-01-18T05:06:27.372Z"
  },
  {
    "id": 2,
    "discipline_id": 2,
    "name": "Birkram",
    "description": "The Hot One",
    "created_at": "2014-01-18T05:13:32.766Z",
    "updated_at": "2014-01-18T05:13:32.766Z"
  },
  {
    "id": 3,
    "discipline_id": 2,
    "name": "Wang Chung",
    "description": "Everybody have fun tonight",
    "created_at": "2014-01-18T05:14:12.588Z",
    "updated_at": "2014-01-18T05:14:12.588Z"
  }
]
##Create A Subject
### Url    
http://localhost:3000/api/subjects
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "subject": {
        "discipline": {
            "id": 1,
            "name": "Tarot Reading"
        },
        "name": "How to Cheat Fate",
        "description": "The Cards Don't Lie Maaaaaaaaaan"
    },
    "token": "28ojjSvUzhQTdrsyM5tA",
    "email": "test3@leonsimmonds.com"
}
### JSON Return String
{
  "id": 3,
  "discipline_id": 1,
  "name": "How to Cheat Fate",
  "description": "The Cards Don't Lie Maaaaaaaaaan",
  "created_at": "2014-01-18T05:06:27.372Z",
  "updated_at": "2014-01-18T05:06:27.372Z"
}
##Fetch A Subject
### Url    
http://localhost:3000/api/subjects/4?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
###Method    
GET
###Header
Content-type: application/json

### GET Query String
token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com

### JSON Return String
{
  "id": 4,
  "discipline_id": 2,
  "name": "Birkram",
  "description": "The Hot One",
  "created_at": "2014-01-18T05:13:32.766Z",
  "updated_at": "2014-01-18T05:13:32.766Z"
}
##Update A Subject
### Url    
http://localhost:3000/api/subjects/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "subject": {
        "discipline": {
            "id": 3
        },
        "name": "Wang Chung",
        "description": "Everybody have fun tonight"
    },
    "token": "28ojjSvUzhQTdrsyM5tA",
    "email": "test3@leonsimmonds.com"
}
### JSON Return String
{
  "id": 4,
  "discipline_id": 3,
  "name": "Wang Chung",
  "description": "Everybody have fun tonight",
  "created_at": "2014-01-18T05:13:32.766Z",
  "updated_at": "2014-01-18T05:21:41.417Z"
}
##Delete A Subject
### Url    
http://localhost:3000/api/subjects/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String

#Appointments
##Fetch All Appointments
### Url
http://localhost:3000/api/appointments?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
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
    "name": null,
    "when": "2014-01-17T07:22:00.000Z",
    "created_at": "2014-01-18T06:40:30.250Z",
    "updated_at": "2014-01-18T06:40:30.250Z",
    "creator_id": null,
    "updater_id": null,
    "subject_id": 4
  },
  ...
  {
    "id": 6,
    "name": null,
    "when": "2014-01-17T07:22:00.000Z",
    "created_at": "2014-01-18T06:52:56.025Z",
    "updated_at": "2014-01-18T06:52:56.025Z",
    "creator_id": null,
    "updater_id": null,
    "subject_id": 5
  }
]
##Create A Appointment
### Url    
http://localhost:3000/api/appointments
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "appointment": {
        "subject": {
            "id": "5"
        },
        "student": [
            {
                "id": "3"
            }
        ],
        "teacher": [
            {
                "id": "1"
            }
        ],
        "when": "2014-01-17T07:22Z"
    },
    "token": "28ojjSvUzhQTdrsyM5tA",
    "email": "test3@leonsimmonds.com"
}
### JSON Return String
{
  "id": 6,
  "name": null,
  "when": "2014-01-17T07:22:00.000Z",
  "created_at": "2014-01-18T06:52:56.025Z",
  "updated_at": "2014-01-18T06:52:56.025Z",
  "creator_id": null,
  "updater_id": null,
  "subject_id": 5
}
##Fetch A Appointment
### Url    
http://localhost:3000/api/appointments/5?token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com
###Method    
GET
###Header
Content-type: application/json

### GET Query String
token=rAoj17gAdDJEudZ8D7yF&email=test1@leonsimmonds.com

### JSON Return String
{
  "id": 5,
  "name": null,
  "when": "2014-01-17T07:22:00.000Z",
  "created_at": "2014-01-18T06:52:30.410Z",
  "updated_at": "2014-01-18T06:52:30.410Z",
  "creator_id": null,
  "updater_id": null,
  "subject_id": 4
}
##Update A Appointment
### Url    
http://localhost:3000/api/appointments/2
###Method    
POST
###Header
Content-type: application/json
### JSON Input
{
    "appointment": {
        "subject": {
            "id": "5"
        },
        "student": [
            {
                "id": "1"
            },
            {
                "id": "3"
            }
        ],
        "teacher": [
            {
                "id": "1"
            }
        ],
        "when": "2014-01-17T07:22Z"
    },
    "token": "28ojjSvUzhQTdrsyM5tA",
    "email": "test3@leonsimmonds.com"
}
### JSON Return String
{
  "id": 5,
  "name": null,
  "when": "2014-01-17T07:22:00.000Z",
  "created_at": "2014-01-18T06:52:30.410Z",
  "updated_at": "2014-01-18T07:03:12.781Z",
  "creator_id": null,
  "updater_id": null,
  "subject_id": 5
}
##Delete A Appointment
### Url    
http://localhost:3000/api/appointments/2
###Method    
DELETE
###Header
Content-type: application/json
### JSON Input
{
   "token": "rAoj17gAdDJEudZ8D7yF",
   "email": "test1@leonsimmonds.com"
}
### JSON Return String
No Return String
