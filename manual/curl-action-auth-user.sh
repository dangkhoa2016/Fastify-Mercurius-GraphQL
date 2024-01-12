# disable user id: 45
# disable cat id: 177 of user id: 33
# disable photo id: 7205 of cat id: 180 of user id: 33

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { login(email: \"isabel.runte-mckenzie@yahoo.com\", password: \"123456\") { user { id, name, email, role }, token, userToken } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "login": {
      "user": {
        "id": "50",
        "name": "ISABEL RUNTE-MCKENZIE",
        "email": "isabel.runte-mckenzie@yahoo.com",
        "role": "user"
      },
      "token": "N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=",
      "userToken": "UiD5bVWKUe4IxQnl1EvSbrd00qXTSQ5PO5RhUufFquPvyMJxpTIbzx6rAI2QiU/0sJUhEalOsQkwPMAa7pu3pyBE0My+Tl+nJxBJ7VFl2t0="
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { follow(userId: 1, followerId: 5) { id, name, image, followed, status, followers_count, likes_count } }"}' \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { unfollow(userId: 1) { id, name, image, followed, status, followers_count, likes_count } }"}' \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { updateLikeCat(catId: \"177\", like: true) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": null
  },
  "errors": [
    {
      "message": "Cat is not active",
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { updateLikeCat(catId: 180, like: false) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": {
      "id": "180",
      "name": "Devon Rex",
      "status": true,
      "likes_count": 35,
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28507
      }
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7205, like: false) { id, title url, status, likes_count, owner { name, id, likes_count }, cat { name, id, likes_count } } }"}' \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7201, like: true) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": {
      "id": "7201",
      "title": "Konopelski Glen",
      "url": "https://loremflickr.com/640/480?lock=1826262934880256",
      "status": true,
      "likes_count": 92,
      "owner": {
        "name": "Marjorie Von",
        "id": "33",
        "likes_count": 28508
      },
      "cat": {
        "name": "Devon Rex",
        "id": 180,
        "likes_count": 35
      }
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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
  -H "x-access-token: N8ybJ2n5bJIPkhzTcnOw6gVG41dTjBeXajg9hQf7oeU=" \
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

