
curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query":"query { user(id: 1) { id, name, followed, photos_count, followers_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "user": {
      "id": "1",
      "name": "MARY DICKI",
      "followed": false,
      "photos_count": 301,
      "followers_count": 14
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { follow(userId: 1) { id, name, image, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "follow": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "follow"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { unfollow(userId: 1) { id, name, image, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "unfollow": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 12
        }
      ],
      "path": [
        "unfollow"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { toggleStatusCat(catId: 1, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { toggleStatusCat(catId: 1, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { updateLikePhoto(photoId: 3, like: false) { id, title url, status, likes_count, owner { name, id, likes_count }, cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { updateLikePhoto(photoId: 3, like: true) { id, title url, status, likes_count, owner { name, id, likes_count }, cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 10, active: true) { id, title url, status, likes_count, owner { name, id, likes_count }, cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 10, active: false) { id, title url, status, likes_count, owner { name, id, likes_count }, cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
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

