# disable user id: 45
# disable cat id: 177 of user id: 33
# disable photo id: 7205 of cat id: 180 of user id: 33

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { login(email: \"Moses_Rogahn@yahoo.com\", password: \"123456\") { user { id, name, role, email }, token, userToken } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "login": {
      "user": {
        "id": "11",
        "name": "MOSES ROGAHN",
        "role": "admin",
        "email": "moses_rogahn@yahoo.com"
      },
      "token": "s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=",
      "userToken": "ucGlimH3Oh7UfHtQ62hbKNj/62r5JLTxYWQDg8YHiFJ5vzDmhXnBtwIr6aksapuAGJkPseaWJrhpeMHdw24B9CBE0My+Tl+nJxBJ7VFl2t0="
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": {
      "id": "43",
      "name": "LEOPOLD BALISTRERI",
      "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/108.jpg",
      "status": false,
      "likes_count": 10710
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusUser(userId: 43, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusUser": {
      "id": "43",
      "name": "LEOPOLD BALISTRERI",
      "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/108.jpg",
      "status": true,
      "likes_count": 10710
    }
  }
}

# check user's follower count before follow

curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
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
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
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
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { unfollow(userId: 1, followerId: 5) { id, name, image, followed, status, followers_count, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "unfollow": {
      "id": "1",
      "name": "MARY DICKI",
      "image": "https://avatars.githubusercontent.com/u/83337568",
      "followed": true,
      "status": true,
      "followers_count": 14,
      "likes_count": 15945
    }
  }
}

# check cat likes count before like

curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "query { cat(id: 177) { id, name, status, updated_at, created_at, owner { name, likes_count }, likes_count, photos_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "cat": {
      "id": "177",
      "name": "Ojos Azules",
      "status": false,
      "updated_at": "2024-02-23 07:55:01",
      "created_at": "2024-02-23 07:55:01",
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28509
      },
      "likes_count": 96,
      "photos_count": 46
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { updateLikeCat(catId: \"177\", like: true) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": {
      "id": "177",
      "name": "Ojos Azules",
      "status": false,
      "likes_count": 97,
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28510
      }
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { updateLikeCat(catId: \"177\", like: false) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": {
      "id": "177",
      "name": "Ojos Azules",
      "status": false,
      "likes_count": 96,
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28509
      }
    }
  }
}


# check cat likes count before like

curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "query { cat(id: 180) { id, name, status, updated_at, created_at, owner { name, likes_count }, likes_count, photos_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "cat": {
      "id": "180",
      "name": "Devon Rex",
      "status": true,
      "updated_at": "2024-02-23 07:55:01",
      "created_at": "2024-02-23 07:55:01",
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28509
      },
      "likes_count": 37,
      "photos_count": 63
    }
  }
}

curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { updateLikeCat(catId: 180, like: false) { id, name, status, likes_count, owner { name, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikeCat": {
      "id": "180",
      "name": "Devon Rex",
      "status": true,
      "likes_count": 36,
      "owner": {
        "name": "Marjorie Von",
        "likes_count": 28508
      }
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusCat(catId: 177, active: false) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": {
      "id": "177",
      "name": "Ojos Azules",
      "image": "https://placekitten.com/400/230",
      "status": false,
      "likes_count": 96
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusCat(catId: 180, active: true) { id, name, image, status, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusCat": {
      "id": "180",
      "name": "Devon Rex",
      "image": "https://placekitten.com/400/299",
      "status": true,
      "likes_count": 35
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7205, like: false) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": {
      "id": "7205",
      "title": "Bill Forges",
      "url": "https://loremflickr.com/640/480?lock=2484438774579200",
      "status": false,
      "likes_count": 38,
      "owner": {
        "name": "Marjorie Von",
        "id": "33",
        "likes_count": 28506
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
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { updateLikePhoto(photoId: 7205, like: true) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "updateLikePhoto": {
      "id": "7205",
      "title": "Bill Forges",
      "url": "https://loremflickr.com/640/480?lock=2484438774579200",
      "status": false,
      "likes_count": 39,
      "owner": {
        "name": "Marjorie Von",
        "id": "33",
        "likes_count": 28507
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
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 31, active: false) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": {
      "id": "31",
      "title": "Goldner Drive",
      "url": "https://loremflickr.com/640/480?lock=5905203714850816",
      "status": false,
      "likes_count": 75,
      "owner": {
        "name": "Mary Dicki",
        "id": "1",
        "likes_count": 15945
      },
      "cat": {
        "name": "Sphynx",
        "id": 185,
        "likes_count": 48
      }
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -H "x-access-token: s0al3wAw72LYL9ZLMTdW1inD+1uwNxohSASWwqtcgNg=" \
  -d '{"query": "mutation { toggleStatusPhoto(photoId: 10, active: true) { id, title url, status, likes_count, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "toggleStatusPhoto": {
      "id": "10",
      "title": "Alfonso Bonilla Aragon International Airport",
      "url": "https://picsum.photos/seed/eHoV8jn/640/480",
      "status": true,
      "likes_count": 96,
      "owner": {
        "name": "Mary Dicki",
        "id": "1",
        "likes_count": 15945
      },
      "cat": {
        "name": "Sphynx",
        "id": 185,
        "likes_count": 48
      }
    }
  }
}

