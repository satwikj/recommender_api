# REST API

REST API for movie recommender using ML


# REST API End-Points

http://127.0.0.1:8080/fliqk/view-movies/   == POST
(Content-Type: application/json  Vary: Accept)

#Note: Request and Response can be modified as required

#Sample Request

{
"moviename":"krish",
"email":"karthik@gmail.com"
}

#Sample Response

{
    "message": "You have provided the movie name krish. Will email relevant suggestions to karthik@gmail.com",
    "ml_test": "krishkarthik@gmail.com"
}
