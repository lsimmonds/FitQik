FitQik
======

FitQik

# Create user input

{
    "api_user": {
        "email": "test3@leonsimmonds.com",
        "password": "testing123",
        "password_confirmation": "testing123"
    }
}

#Sign In

## Url
http://localhost:3000/api/users/sign_in

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


