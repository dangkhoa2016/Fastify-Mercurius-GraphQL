const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
	const tableExists = await knex.schema.hasTable(tableName);
	// console.log(`Table '${tableName}' exists: ${tableExists}`);
	return tableExists;
}

exports.seed = async function (knex) {
	// await knex.raw('TRUNCATE TABLE photos RESTART IDENTITY CASCADE');
	if (await checkIfTableExists(knex, 'sqlite_sequence')) {
		await knex.raw("DELETE FROM sqlite_sequence WHERE name = 'photos';");
	}
	// if (await checkIfTableExists(knex, 'photos')) {
	//   await knex.raw('DELETE FROM photos;');
	// }

	const cat_ids = (await knex.select('id').from('cats')).map((row) => row.id);
	// console.log('cat_ids', cat_ids);

	const random = (min, max) => {
		return Math.floor(Math.random() * (max - min) + min);
	};

	return knex('photos')
		.del()
		.finally(async () => {
			// create random photos for each cat
			for (const cat_id of cat_ids) {
				const number_of_photos = random(0, 100);
				if (number_of_photos > 0) {
					const photos = Array(number_of_photos)
						.fill(null)
						.map(() => ({
							title:
								random(1, 100) > 60
									? faker.location.street()
									: random(1, 100) > 50
										? faker.vehicle.vehicle()
										: faker.airline.airport().name,
							description: faker.lorem.sentences({ min: 1, max: 8 }),
							cat_id,
							url: faker.image.url(),
						}));

					// console.log('photos', photos);
					await knex('photos').insert(photos);
				}
			}
		});
};
