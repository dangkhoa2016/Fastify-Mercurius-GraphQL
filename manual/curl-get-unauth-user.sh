# disable user id: 45
# disable cat id: 177 of user id: 33
# disable photo id: 7205 of cat id: 180 of user id: 33

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { topUsersByLikeCount { id, name, email, image, role, followed, followers_count, country, cats_count, photos_count, status, updated_at, created_at, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "topUsersByLikeCount": [
      {
        "id": "33",
        "name": "MARJORIE VON",
        "email": "marjorie.von65@gmail.com",
        "image": "https://avatars.githubusercontent.com/u/2552051",
        "role": "user",
        "followed": false,
        "followers_count": 22,
        "country": "Paraguay",
        "cats_count": 8,
        "photos_count": 502,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1705701023424,
        "likes_count": 28509
      },
      {
        "id": "50",
        "name": "ISABEL RUNTE-MCKENZIE",
        "email": "isabel.runte-mckenzie@yahoo.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1022.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 21,
        "country": "Netherlands",
        "cats_count": 9,
        "photos_count": 527,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1687947897885,
        "likes_count": 26226
      },
      {
        "id": "39",
        "name": "KAELA POLLICH",
        "email": "kaela.pollich@yahoo.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1134.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 14,
        "country": "Italy",
        "cats_count": 7,
        "photos_count": 465,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1683009336664,
        "likes_count": 23626
      },
      {
        "id": "23",
        "name": "ALEXANE NOLAN",
        "email": "alexane.nolan45@gmail.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/567.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 19,
        "country": "Montenegro",
        "cats_count": 8,
        "photos_count": 452,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1697865183456,
        "likes_count": 23242
      }
    ]
  }
}

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { topUsersByLikeCount(pageSize: 8) { id, name, email, image, role, followed, followers_count, country, cats_count, photos_count, status, updated_at, created_at, likes_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "topUsersByLikeCount": [
      {
        "id": "33",
        "name": "MARJORIE VON",
        "email": "marjorie.von65@gmail.com",
        "image": "https://avatars.githubusercontent.com/u/2552051",
        "role": "user",
        "followed": false,
        "followers_count": 22,
        "country": "Paraguay",
        "cats_count": 8,
        "photos_count": 502,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1705701023424,
        "likes_count": 28509
      },
      {
        "id": "50",
        "name": "ISABEL RUNTE-MCKENZIE",
        "email": "isabel.runte-mckenzie@yahoo.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1022.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 21,
        "country": "Netherlands",
        "cats_count": 9,
        "photos_count": 527,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1687947897885,
        "likes_count": 26226
      },
      {
        "id": "39",
        "name": "KAELA POLLICH",
        "email": "kaela.pollich@yahoo.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1134.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 14,
        "country": "Italy",
        "cats_count": 7,
        "photos_count": 465,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1683009336664,
        "likes_count": 23626
      },
      {
        "id": "23",
        "name": "ALEXANE NOLAN",
        "email": "alexane.nolan45@gmail.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/567.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 19,
        "country": "Montenegro",
        "cats_count": 8,
        "photos_count": 452,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1697865183456,
        "likes_count": 23242
      },
      {
        "id": "29",
        "name": "RAQUEL MUELLER-LEHNER",
        "email": "raquel.mueller-lehner@hotmail.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/915.jpg",
        "role": "admin",
        "followed": false,
        "followers_count": 1,
        "country": "Romania",
        "cats_count": 9,
        "photos_count": 445,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1679590791031,
        "likes_count": 22722
      },
      {
        "id": "46",
        "name": "EMMANUEL DECKOW",
        "email": "emmanuel_deckow15@hotmail.com",
        "image": "https://avatars.githubusercontent.com/u/6862757",
        "role": "admin",
        "followed": false,
        "followers_count": 9,
        "country": "Saint Helena",
        "cats_count": 6,
        "photos_count": 440,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1705676215348,
        "likes_count": 22221
      },
      {
        "id": "16",
        "name": "ALEXANDER KOEPP",
        "email": "alexander_koepp@hotmail.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1119.jpg",
        "role": "user",
        "followed": false,
        "followers_count": 1,
        "country": "Fiji",
        "cats_count": 8,
        "photos_count": 418,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1686750263671,
        "likes_count": 21711
      },
      {
        "id": "35",
        "name": "ELSE CUMMINGS",
        "email": "else.cummings@hotmail.com",
        "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/580.jpg",
        "role": "admin",
        "followed": false,
        "followers_count": 10,
        "country": "Curacao",
        "cats_count": 7,
        "photos_count": 413,
        "status": true,
        "updated_at": 1708674900000,
        "created_at": 1702023444977,
        "likes_count": 21538
      }
    ]
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { counters { users, cats, photos, countries } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "counters": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "counters"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { userFields }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "userFields": [
      "id",
      "name",
      "email",
      "image",
      "role",
      "status",
      "updated_at",
      "created_at",
      "cats_count",
      "photos_count",
      "likes_count",
      "followers_count",
      "followed",
      "country",
      "twitter_url",
      "facebook_url",
      "instagram_url",
      "linkedin_url",
      "github_url",
      "website_url",
      "pinterest_url",
      "youtube_url",
      "bio",
      "job_title",
      "phone_number",
      "location",
      "gender"
    ]
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { catFields }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "catFields": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "catFields"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { photoFields }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photoFields": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photoFields"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { catsGroupByUsers { id name count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "catsGroupByUsers": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "catsGroupByUsers"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { photosGroupByCats { id name count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photosGroupByCats": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photosGroupByCats"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { users(pageIndex: 1, pageSize: 5) { items { id, name, email, image, followed, country, role, status, created_at, updated_at, likes_count, cats_count, photos_count, followers_count } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "users": {
      "items": [
        {
          "id": "1",
          "name": "MARY DICKI",
          "email": "mary.dicki@hotmail.com",
          "image": "https://avatars.githubusercontent.com/u/83337568",
          "followed": false,
          "country": "Anguilla",
          "role": "user",
          "status": true,
          "created_at": 1708018883641,
          "updated_at": 1708674900000,
          "likes_count": 15945,
          "cats_count": 5,
          "photos_count": 301,
          "followers_count": 15
        },
        {
          "id": "2",
          "name": "CLINTON JACOBI",
          "email": "clinton_jacobi54@gmail.com",
          "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/520.jpg",
          "followed": false,
          "country": "Maldives",
          "role": "user",
          "status": true,
          "created_at": 1691812086880,
          "updated_at": 1708674900000,
          "likes_count": 15740,
          "cats_count": 9,
          "photos_count": 309,
          "followers_count": 26
        },
        {
          "id": "3",
          "name": "ADELIA BAUMBACH",
          "email": "adelia_baumbach38@yahoo.com",
          "image": "https://avatars.githubusercontent.com/u/25488145",
          "followed": false,
          "country": "Qatar",
          "role": "user",
          "status": true,
          "created_at": 1688901066128,
          "updated_at": 1708674900000,
          "likes_count": 13625,
          "cats_count": 6,
          "photos_count": 266,
          "followers_count": 7
        },
        {
          "id": "4",
          "name": "AVIS FAY",
          "email": "avis.fay@gmail.com",
          "image": "https://avatars.githubusercontent.com/u/40833253",
          "followed": false,
          "country": "Trinidad and Tobago",
          "role": "user",
          "status": true,
          "created_at": 1677466808078,
          "updated_at": 1708674900000,
          "likes_count": 11344,
          "cats_count": 4,
          "photos_count": 204,
          "followers_count": 25
        },
        {
          "id": "5",
          "name": "RANSOM ERDMAN",
          "email": "ransom_erdman75@yahoo.com",
          "image": "https://avatars.githubusercontent.com/u/38088286",
          "followed": false,
          "country": "Italy",
          "role": "user",
          "status": true,
          "created_at": 1677360277387,
          "updated_at": 1708674900000,
          "likes_count": 69,
          "cats_count": 1,
          "photos_count": 0,
          "followers_count": 11
        }
      ],
      "total_items": 50,
      "total_pages": 10
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { users(pageIndex: 9, pageSize: 5) { items { id, name, email, image, followed, country, role, status, created_at, updated_at, likes_count, cats_count, photos_count, followers_count } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "users": {
      "items": [
        {
          "id": "41",
          "name": "SADYE WILLMS-JERDE",
          "email": "sadye_willms-jerde37@gmail.com",
          "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1144.jpg",
          "followed": false,
          "country": "Saint Barthelemy",
          "role": "user",
          "status": true,
          "created_at": 1690385797407,
          "updated_at": 1708674900000,
          "likes_count": 17368,
          "cats_count": 5,
          "photos_count": 332,
          "followers_count": 26
        },
        {
          "id": "42",
          "name": "BUD LEHNER",
          "email": "bud_lehner23@hotmail.com",
          "image": "https://avatars.githubusercontent.com/u/77447863",
          "followed": false,
          "country": "Mauritania",
          "role": "user",
          "status": true,
          "created_at": 1681145776955,
          "updated_at": 1708674900000,
          "likes_count": 10447,
          "cats_count": 6,
          "photos_count": 204,
          "followers_count": 6
        },
        {
          "id": "43",
          "name": "LEOPOLD BALISTRERI",
          "email": "leopold.balistreri63@gmail.com",
          "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/108.jpg",
          "followed": false,
          "country": "Sierra Leone",
          "role": "user",
          "status": true,
          "created_at": 1694881413894,
          "updated_at": 1708674900000,
          "likes_count": 10710,
          "cats_count": 4,
          "photos_count": 208,
          "followers_count": 15
        },
        {
          "id": "44",
          "name": "DARREN CRIST",
          "email": "darren_crist25@gmail.com",
          "image": "https://avatars.githubusercontent.com/u/173332",
          "followed": false,
          "country": "Sudan",
          "role": "user",
          "status": true,
          "created_at": 1685849057648,
          "updated_at": 1708674900000,
          "likes_count": 2789,
          "cats_count": 1,
          "photos_count": 51,
          "followers_count": 20
        },
        {
          "id": "46",
          "name": "EMMANUEL DECKOW",
          "email": "emmanuel_deckow15@hotmail.com",
          "image": "https://avatars.githubusercontent.com/u/6862757",
          "followed": false,
          "country": "Saint Helena",
          "role": "admin",
          "status": true,
          "created_at": 1705676215348,
          "updated_at": 1708674900000,
          "likes_count": 22221,
          "cats_count": 6,
          "photos_count": 440,
          "followers_count": 9
        }
      ],
      "total_items": 50,
      "total_pages": 10
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { user(id: \"33\") { id, name, email, image, followed, country, role, status, created_at, updated_at, likes_count, cats_count, photos_count, followers_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "user": {
      "id": "33",
      "name": "MARJORIE VON",
      "email": "marjorie.von65@gmail.com",
      "image": "https://avatars.githubusercontent.com/u/2552051",
      "followed": false,
      "country": "Paraguay",
      "role": "user",
      "status": true,
      "created_at": 1705701023424,
      "updated_at": 1708674900000,
      "likes_count": 28509,
      "cats_count": 8,
      "photos_count": 502,
      "followers_count": 22
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { user(id: 50) { id, name, email, image, followed, country, role, status, created_at, updated_at, likes_count, cats_count, photos_count, followers_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "user": {
      "id": "50",
      "name": "ISABEL RUNTE-MCKENZIE",
      "email": "isabel.runte-mckenzie@yahoo.com",
      "image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1022.jpg",
      "followed": false,
      "country": "Netherlands",
      "role": "user",
      "status": true,
      "created_at": 1687947897885,
      "updated_at": 1708674900000,
      "likes_count": 26226,
      "cats_count": 9,
      "photos_count": 527,
      "followers_count": 21
    }
  }
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { catsByUserId(userId: 33, pageIndex: 1, pageSize: 5) { items { id, name, image, description, coat_color, eye_color, breed, origin, weight, height, user_id, status, gender, updated_at, created_at, birthday, owner { name }, likes_count, photos_count } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "catsByUserId": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "catsByUserId"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { cats(pageIndex: 1, pageSize: 5) { items { id, name, image, description, coat_color, eye_color, breed, origin, weight, height, user_id, status, gender, updated_at, created_at, birthday, owner { name, likes_count }, likes_count, photos_count } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "cats": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "cats"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { cat(id: 177) { id, name, image, description, coat_color, eye_color, breed, origin, weight, height, user_id, status, gender, updated_at, created_at, birthday, owner { name }, likes_count, photos_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "cat": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "cat"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { cat(id: 180) { id, name, image, description, coat_color, eye_color, breed, origin, weight, height, user_id, status, gender, updated_at, created_at, birthday, owner { name }, likes_count, photos_count } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "cat": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "cat"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { photosByCatId(catId: 177, pageIndex: 1, pageSize: 5) { items { id title description likes_count url cat_id status updated_at created_at owner { name, id, likes_count } } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photosByCatId": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photosByCatId"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { photosByCatId(catId: 180, pageIndex: 1, pageSize: 5) { items { id title description likes_count url cat_id status updated_at created_at owner { name } } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photosByCatId": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photosByCatId"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { photosByUserId(userId: 33, pageIndex: 1, pageSize: 5) { items { id title description likes_count url cat_id status updated_at created_at owner { name } } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photosByUserId": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photosByUserId"
      ]
    }
  ]
}


curl -X POST -H "Content-Type: application/json" \
  -d '{"query":"query { photos(pageIndex: 1, pageSize: 5) { items { id title url description cat_id likes_count status updated_at created_at owner { name, id, likes_count } cat { name, id, likes_count } } total_items total_pages } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photos": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photos"
      ]
    }
  ]
}

curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { photo(id: 7205) { id, title, url, status, description, cat_id, likes_count, updated_at, created_at, owner { name, id, likes_count } cat { name, id, likes_count } } }"}' \
  http://localhost:4000/graphql | jq
{
  "data": {
    "photo": null
  },
  "errors": [
    {
      "message": "Unauthenticated.",
      "locations": [
        {
          "line": 1,
          "column": 9
        }
      ],
      "path": [
        "photo"
      ]
    }
  ]
}

