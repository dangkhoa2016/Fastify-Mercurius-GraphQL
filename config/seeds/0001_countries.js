const { faker } = require('@faker-js/faker');

async function checkIfTableExists(knex, tableName) {
	const tableExists = await knex.schema.hasTable(tableName);
	// console.log(`Table '${tableName}' exists: ${tableExists}`);
	return tableExists;
}

exports.seed = async function (knex) {
	// await knex.raw('TRUNCATE TABLE countries RESTART IDENTITY CASCADE');
	if (await checkIfTableExists(knex, 'sqlite_sequence')) {
		await knex.raw("DELETE FROM sqlite_sequence WHERE name = 'countries';");
	}
	if (await checkIfTableExists(knex, 'countries')) {
		await knex.raw('DELETE FROM countries;');
	}

	return knex('countries')
		.del()
		.finally(() => {
			const countries = faker.definitions.location.country.map((country) => ({
				name: country,
			}));
			return knex('countries').insert(countries);
		});
};
