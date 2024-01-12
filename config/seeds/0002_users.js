const bcrypt = require('bcrypt')
const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
  const tableExists = await knex.schema.hasTable(tableName);
  // console.log(`Table '${tableName}' exists: ${tableExists}`);
  return tableExists;
};

const random = (min, max) => {
  return Math.floor(Math.random() * (max - min) + min)
};

const users = Array(50).fill().map(() => {
  const firstName = faker.person.firstName();
  const lastName = faker.person.lastName();
  return {
    location: faker.location.state(),
    instagram_url: `https://www.instagram.com/${firstName}.${lastName}/`,
    facebook_url: `https://www.facebook.com/${firstName}.${lastName}/`,
    twitter_url: `https://twitter.com/${firstName}.${lastName}/`,
    linkedin_url: `https://www.linkedin.com/in/${firstName}.${lastName}/`,
    website_url: random(1, 10) > 4 ? `${firstName}.${lastName}.local` : faker.internet.url(),
    github_url: `https://github.com/${firstName}.${lastName}`,
    youtube_url: `https://www.youtube.com/channel/${firstName}_${lastName}`,
    pinterest_url: `https://www.pinterest.com/${firstName}_${lastName}/`,
    phone_number: faker.phone.number(),
    bio: faker.lorem.paragraphs(faker.number.int({ min: 2, max: 10 })),
    job_title: faker.person.jobTitle(),
    gender: faker.person.sex(),
    name: `${firstName} ${lastName}`,
    email: faker.internet.email({ firstName, lastName }),
    image: faker.image.avatar(),
    password: bcrypt.hashSync('123456', bcrypt.genSaltSync(10)),
    role: random(1, 100) > 70 ? 'admin' : 'user',
    provider: random(1, 100) > 50 ? 'google' : 'credeintials',
    created_at: faker.date.past(),
  }
});

exports.seed = async function (knex) {
  // await knex.raw('TRUNCATE TABLE users RESTART IDENTITY CASCADE');
  if (await checkIfTableExists(knex, 'sqlite_sequence')) {
    await knex.raw("DELETE FROM sqlite_sequence WHERE name = 'users';");
  }
  // if (await checkIfTableExists(knex, 'users')) {
  //   await knex.raw('DELETE FROM users;');
  // }

  return knex('users').del()
    .finally(async () => {
      const countries = await knex('countries').select('id');
      users.forEach(user => {
        user.country_id = countries[random(0, countries.length - 1)].id;
      });
      return knex('users').insert(users);
    });
}
