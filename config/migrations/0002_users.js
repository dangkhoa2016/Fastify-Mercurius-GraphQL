exports.up = function (knex) {
	return knex.schema.createTable('users', (table) => {
		table.increments('id').index();
		table.string('name', 255).notNullable();
		table.string('email', 255).notNullable().unique();
		table.string('image', 255);
		table.string('role', 255).notNullable().defaultTo('admin');
		table.text('password', 255).notNullable();
		table.boolean('status').notNullable().defaultTo(true);
		table.text('provider', 255).notNullable().defaultTo('credentials');
		table.string('location', 255);
		table.integer('country_id');
		table.string('instagram_url', 255);
		table.string('facebook_url', 255);
		table.string('twitter_url', 255);
		table.string('linkedin_url', 255);
		table.string('website_url', 255);
		table.string('github_url', 255);
		table.string('youtube_url', 255);
		table.string('pinterest_url', 255);
		table.string('phone_number', 20);
		table.string('bio', 555);
		table.string('job_title', 255);
		table.string('gender', 255);
		table.integer('likes_count').defaultTo(0);

		table.timestamps(false, true);
	});
};

exports.down = (knex) => {
	return knex.schema.dropTable('users');
};
