== README
```
"apis": [
  {
    "path": "/api/registrations",
    "method": "POST",
    "summary": "Create a new user",
    "parameters": [
      {
        "user": {
          "email": "string",
          "password": "string",
          "password_confirmation": "string"
        }
      }
    ]
  },
  {
    "path": "/api/sessions",
    "method": "POST",
    "summary": "User login",
    "parameters": [
      {
        "user": {
          "email": "string",
          "password": "string"
        }
      }
    ]
  },
  {
    "path": "/api/sessions",
    "method": "DELETE",
    "summary": "User logout",
    "parameters": [
      {
        "auth_token": "string"
      }
    ]
  },
  {
    "path": "/api/links",
    "method": "GET",
    "summary": "Returns user's links",
    "parameters": [
      {
        "auth_token": "string"
      }
    ]
  },
  {
    "path": "/api/links",
    "method": "POST",
    "summary": "Create new link",
    "parameters": [
      {
        "auth_token": "string",
        "link_submission": {  
          "url": "string",
          "title": "string",
          "content": "string",
          "link_interactions": [  
            {  
              "id": "integer",
              "checked": "integer"
            }
          ]
        }
      }
    ]
  },
  {
    "path": "/api/links/new",
    "method": "GET",
    "summary": "Returns url's content",
    "parameters": [
      {
        "auth_token": "string"
        "url": "string"
      }
    ]
  },
  {
    "path": "/api/links/:id",
    "method": "GET",
    "summary": "Returns a link",
    "parameters": [
      {
        "auth_token": "string"
        "id": "integer"
      }
    ]
  }
]
```
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
