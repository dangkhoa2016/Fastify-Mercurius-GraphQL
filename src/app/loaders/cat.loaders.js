'use strict';
const helpers = require('../../libs/helpers');

module.exports = {
	Cat: {
		owner: (users, { app }) => {
			return helpers.fetchOwners(app.knex, {
				tableName: 'cats',
				idField: 'user_id',
				relatedTableName: 'users',
				records: users,
				selectFields: ['users.id', 'users.name', 'users.likes_count'],
			});
		},
		photos_count: async (cats, { app, current_user }) => {
			const { knex } = app;

			const filter = {};
			const users = await knex('cats')
				.select('user_id')
				.whereIn(
					'id',
					cats.map(({ obj }) => obj.id)
				)
				.distinct();
			// console.log('users', users);
			const is_current_user_request =
				current_user &&
				users.length === 1 &&
				current_user.id.toString() === users[0].user_id.toString();
			if (
				!current_user ||
				(current_user.role !== 'admin' && !is_current_user_request)
			)
				filter['photos.status'] = true;

			const result = await helpers.getCounts(knex, {
				items: cats,
				filter,
				groupFieldName: 'catId',
				foreignKeyName: 'cat_id',
				tableName: 'cats',
				countField: 'photos.id',
				relatedTableName: 'photos',
			});

			return cats.map(({ obj }) => {
				return (result.find((record) => record[obj.id]) ?? {})[obj.id] ?? 0;
			});
		},
	},
};
