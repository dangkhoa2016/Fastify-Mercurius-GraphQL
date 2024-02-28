'use strict';
const helpers = require('../../libs/helpers');

module.exports = {
	Query: {
		cats: (_, { pageIndex, pageSize = 10 }, { app, current_user }) => {
			// console.log('pageIndex', pageIndex);
			// console.log('pageSize', pageSize);

			const filter = {};
			if (!current_user || current_user.role !== 'admin')
				filter['cats.status'] = true;

			return helpers.getWithPagination(app.knex, {
				tableName: 'cats',
				conditions: filter,
				options: { pageIndex, pageSize },
			});
		},

		cat: async (_, { id }, context) => {
			const { current_user } = context;

			const cat = await context.app.knex('cats').where({ id }).first();

			if (!cat) throw new Error('Cat not found');

			if (!cat.status) {
				if (
					!current_user ||
					(current_user.role !== 'admin' &&
						cat.user_id.toString() !== current_user.id.toString())
				)
					throw new Error('Cat is not active');
			}

			context.app.pubsub.publish(context);

			return cat;
		},

		catsByUserId: (
			_,
			{ userId, pageIndex, pageSize = 10 },
			{ app, current_user }
		) => {
			// console.log('pageIndex', pageIndex);
			// console.log('pageSize', pageSize);
			// console.log('userId', userId);
			// console.log('current_user', current_user);
			const filter = { user_id: userId };

			const is_current_user_request =
				current_user && current_user.id.toString() === userId.toString();
			if (
				!current_user ||
				(current_user.role !== 'admin' && !is_current_user_request)
			)
				filter['cats.status'] = true;

			return helpers.getWithPagination(app.knex, {
				tableName: 'cats',
				conditions: filter,
				options: { pageIndex, pageSize },
			});
		},
	},

	Mutation: {
		updateLikeCat: async (_, args, { app, current_user }) => {
			if (!current_user)
				throw new Error(
					`Only logged in user can ${args.like ? 'like' : 'unlike'} a cat`
				);

			const { knex } = app;
			const updateAction = args.like ? 'likes_count + 1' : 'likes_count - 1';

			let cat = await knex('cats').where({ id: args.catId }).first();
			if (!cat) throw new Error('Cat not found');

			if (!cat.status) {
				if (
					current_user.role !== 'admin' &&
					cat.user_id.toString() !== current_user.id.toString()
				)
					throw new Error('Cat is not active');
			}

			if (cat.user_id.toString() === current_user.id.toString())
				throw new Error(
					`You cannot ${args.like ? 'like' : 'unlike'} your own cat`
				);

			// update cat like count
			cat = await knex('cats')
				.where({ id: args.catId })
				.update({ likes_count: knex.raw(updateAction) })
				.returning('*');

			// update user like count
			await knex('users')
				.where({ id: cat[0].user_id })
				.update({ likes_count: knex.raw(updateAction) });

			return cat[0];
		},

		toggleStatusCat: (_, args, { app, current_user }) => {
			if (!current_user || current_user.role !== 'admin')
				throw new Error("Only admin can update cat's status");

			return helpers.toggleStatus(app.knex, {
				tableName: 'cats',
				idField: 'id',
				id: args.catId,
				status: args.active,
				entityName: 'Cat',
			});
		},
	},
};
