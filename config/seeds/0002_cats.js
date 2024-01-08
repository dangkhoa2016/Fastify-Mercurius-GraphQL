const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
  const tableExists = await knex.schema.hasTable(tableName);
  console.log(`Table '${tableName}' exists: ${tableExists}`);
  return tableExists;
};

exports.seed = async function (knex) {
  // await knex.raw('TRUNCATE TABLE cats RESTART IDENTITY CASCADE');
  if (await checkIfTableExists(knex, 'sqlite_sequence')) {
    await knex.raw(`DELETE FROM sqlite_sequence WHERE name = 'cats';`);
  }
  if (await checkIfTableExists(knex, 'cats')) {
    await knex.raw(`DELETE FROM cats;`);
  }

  const [users_count] = await knex('users').count()
  console.log('users_count', users_count);

  const random = (min, max) => {
    return Math.floor(Math.random() * (max - min) + min)
  }

  return knex('cats').del()
    .finally(() => {
      const cats = Array(8).fill(null).map(() => ({
        name: faker.animal.cat(),
        user_id: random(1, users_count['count(*)']),
        image: `https://placekitten.com/200/${random(200, 220)}`
      }));
      
      console.log('cats', cats);
      return knex('cats').insert(cats);
    });
}
