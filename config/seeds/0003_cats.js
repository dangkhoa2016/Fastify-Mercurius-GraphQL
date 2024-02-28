const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
	const tableExists = await knex.schema.hasTable(tableName);
	// console.log(`Table '${tableName}' exists: ${tableExists}`);
	return tableExists;
}

exports.seed = async function (knex) {
	// await knex.raw('TRUNCATE TABLE cats RESTART IDENTITY CASCADE');
	if (await checkIfTableExists(knex, 'sqlite_sequence')) {
		await knex.raw("DELETE FROM sqlite_sequence WHERE name = 'cats';");
	}
	// if (await checkIfTableExists(knex, 'cats')) {
	//   await knex.raw('DELETE FROM cats;');
	// }

	const user_ids = (await knex.select('id').from('users')).map((row) => row.id);
	// console.log('user_ids', user_ids);

	const random = (min, max) => {
		return Math.floor(Math.random() * (max - min) + min);
	};

	return knex('cats')
		.del()
		.finally(async () => {
			// create random cats for each user
			for (const user_id of user_ids) {
				const number_of_cats = random(0, 10);
				if (number_of_cats > 0) {
					const cats = Array(number_of_cats)
						.fill(null)
						.map(() => ({
							description: faker.lorem.paragraph(),
							coat_color: faker.color.human(),
							eye_color: faker.color.human(),
							breed: faker.animal.cat(),
							origin: faker.location.country(),
							weight: faker.number.float({ multipleOf: 0.25, min: 0, max: 40 }),
							height: faker.number.float({ multipleOf: 0.25, min: 0, max: 10 }),
							gender: faker.person.gender(),
							birthday: faker.date.past({ years: 20 }),
							name: faker.animal.cat(),
							user_id,
							created_at: faker.date.past(),
							image: `https://placekitten.com/400/${random(300, 400)}`,
						}));

					// console.log('cats', cats);
					await knex('cats').insert(cats);
				}
			}
		});
};
