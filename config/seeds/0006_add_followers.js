const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
  const tableExists = await knex.schema.hasTable(tableName);
  // console.log(`Table '${tableName}' exists: ${tableExists}`);
  return tableExists;
};

exports.seed = async function (knex) {
  // await knex.raw('TRUNCATE TABLE users_followers RESTART IDENTITY CASCADE');
  if (await checkIfTableExists(knex, 'sqlite_sequence')) {
    await knex.raw("DELETE FROM sqlite_sequence WHERE name = 'users_followers';");
  }
  // if (await checkIfTableExists(knex, 'users_followers')) {
  //   await knex.raw('DELETE FROM users_followers;');
  // }

  const user_ids = (await knex.select('id').from('users')).map(row => row.id);
  // console.log('user_ids', user_ids);

  const random = (min, max) => {
    return Math.floor(Math.random() * (max - min) + min)
  }

  return knex('users_followers').del().finally(async () => {
    // create random followers for each user
    for (const user_id of user_ids) {
      const number_of_followers = random(0, 30);
      if (number_of_followers > 0) {
        const temp_user_ids = user_ids.filter(id => id !== user_id);
        const followers = faker.helpers.arrayElements(temp_user_ids, number_of_followers).map(id => { 
          return {
            user_id,
            follower_id: id
          }
        });

        // console.log('followers', followers);
        await knex('users_followers').insert(followers);
      }
    }
  });
}
