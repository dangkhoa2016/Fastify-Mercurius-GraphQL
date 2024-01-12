# disable user id: 45
# disable cat id: 177 of user id: 33
# disable photo id: 7205 of cat id: 180 of user id: 33

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { login(email: \"marjorie.von65@gmail.com\", password: \"123456\") { user { id, name, email, role }, token, userToken } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "login": {
      "user": {
        "id": "33",
        "name": "MARJORIE VON",
        "email": "marjorie.von65@gmail.com",
        "role": "user"
      },
      "token": "0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=",
      "userToken": "5bKR/c9kLiZyLXu+vcpeHq7l7gs+6Cn0n7rqQfoDav9Ns/WJB6La1FKWUBQFvnSBXKGje2UxQpN1NdQcqToOWiBE0My+Tl+nJxBJ7VFl2t0="
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": null
  },
  "errors": [
    {
      "message": "Only admin can update user's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusUser"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": null
  },
  "errors": [
    {
      "message": "Only admin can update user's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusUser"
      ]
    }
  ]
}


# check user's follower count before follow

curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query":"query { user(id: 1) { id, name, followed, photos_count, followers_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "user": {
      "id": "1",
      "name": "MARY DICKI",
      "followed": true,
      "photos_count": 301,
      "followers_count": 15
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { follow(userId: 1, followerId: 5) { id, name, image, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "follow": {
      "id": "1",
      "name": "MARY DICKI",
      "image": "https://avatars.githubusercontent.com/u/83337568",
      "status": true,
      "followers_count": 15,
      "likes_count": 15945
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { follow(userId: 1) { id, name, image, followed, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "follow": {
      "id": "1",
      "name": "MARY DICKI",
      "image": "https://avatars.githubusercontent.com/u/83337568",
      "followed": true,
      "status": true,
      "followers_count": 15,
      "likes_count": 15945
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { unfollow(userId: 1, followerId: 5) { id, name, image, followed, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "unfollow": {
      "id": "1",
      "name": "MARY DICKI",
      "image": "https://avatars.githubusercontent.com/u/83337568",
      "followed": false,
      "status": true,
      "followers_count": 14,
      "likes_count": 15945
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { unfollow(userId: 1) { id, name, image, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "unfollow": {
      "id": "1",
      "name": "MARY DICKI",
      "image": "https://avatars.githubusercontent.com/u/83337568",
      "status": true,
      "followers_count": 14,
      "likes_count": 15945
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { updateLikeCat(catId: \"177\", like: true) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": null
  },
  "errors": [
    {
      "message": "You cannot like your own cat",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "updateLikeCat"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { updateLikeCat(catId: 180, like: false) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": null
  },
  "errors": [
    {
      "message": "You cannot unlike your own cat",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "updateLikeCat"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusCat(catId: 177, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": null
  },
  "errors": [
    {
      "message": "Only admin can update cat's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusCat"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusCat(catId: 180, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": null
  },
  "errors": [
    {
      "message": "Only admin can update cat's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusCat"
      ]
    }
  ]
}





curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7205, like: false) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": null
  },
  "errors": [
    {
      "message": "Photo is not active",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "updateLikePhoto"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7201, like: true) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": null
  },
  "errors": [
    {
      "message": "You can't like your own photo",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "updateLikePhoto"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 31, active: false) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": null
  },
  "errors": [
    {
      "message": "Only admin can update photo's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusPhoto"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: 0jFeUdJX6zq5wonaRVtKB5oQ0FPtUaMGVnLoMrEC9EA=" \
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 10, active: true) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": null
  },
  "errors": [
    {
      "message": "Only admin can update photo's status",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "toggleStatusPhoto"
      ]
    }
  ]
}

