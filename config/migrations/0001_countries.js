exports.up = function (knex) {
	return knex.schema.createTable('countries', (table) => {
		table.increments('id').index();
		table.string('name', 255).notNullable();

		table.timestamps(false, true);
	});
};

exports.down = (knex) => {
	return knex.schema.dropTable('countries');
};
