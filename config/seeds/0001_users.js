const bcrypt = require('bcrypt')
const faker = require('faker')

const random = (min, max) => {
  return Math.floor(Math.random() * (max - min) + min)
}

const users = Array(4).fill().map(() => ({
  name: faker.name.findName(),
  email: faker.internet.email().toLowerCase(),
  image: `https://placekitten.com/200/${random(200, 220)}`,
  password: bcrypt.hashSync('123456', bcrypt.genSaltSync(10))
}))

exports.seed = async function (knex) {
  await knex.raw('TRUNCATE TABLE users RESTART IDENTITY CASCADE')

  return knex('users').del()
    .then(function () {
      return knex('users').insert(users)
    })
}
