const bcrypt = require('bcrypt')
const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
  const tableExists = await knex.schema.hasTable(tableName);
  console.log(`Table '${tableName}' exists: ${tableExists}`);
  return tableExists;
};

const random = (min, max) => {
  return Math.floor(Math.random() * (max - min) + min)
}

const users = Array(4).fill().map(() => ({
  name: faker.person.fullName(),
  email: faker.internet.email().toLowerCase(),
  image: `https://placekitten.com/200/${random(200, 220)}`,
  password: bcrypt.hashSync('123456', bcrypt.genSaltSync(10))
}))

exports.seed = async function (knex) {
  // await knex.raw('TRUNCATE TABLE users RESTART IDENTITY CASCADE');
  if (await checkIfTableExists(knex, 'sqlite_sequence')) {
    await knex.raw(`DELETE FROM sqlite_sequence WHERE name = 'users';`);
  }
  if (await checkIfTableExists(knex, 'users')) {
    await knex.raw(`DELETE FROM users;`);
  }

  return knex('users').del()
    .finally(function () {
      return knex('users').insert(users)
    });
}
