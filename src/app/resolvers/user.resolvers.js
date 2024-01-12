'use strict'
const helpers = require('../../libs/helpers');

module.exports = {
  Query: {
    users: async (_, { pageIndex, pageSize = 10 }, { app, current_user }) => {
      // console.log('pageIndex', pageIndex);
      // console.log('pageSize', pageSize);

      const filter = { };
      if (!current_user || current_user.role !== 'admin')
        filter['users.status'] = true;

      const result = await helpers.getWithPagination(app.knex, {
        tableName: 'users', conditions: filter,
        options: { pageIndex, pageSize }
      });

      result.items = result.items.map(u => {
        u.updated_at = new Date(u.updated_at).valueOf();
        return u;
      });

      return result;
    },

    topUsersByLikeCount: async (_, { pageSize = 4 }, { app, current_user }) => {
      // console.log('pageSize', pageSize);

      const filter = { };
      if (!current_user || current_user.role !== 'admin')
        filter['users.status'] = true;

      const result = await helpers.getWithPagination(app.knex, {
        tableName: 'users', conditions: filter,
        options: {
          onlyItems: true,
          pageSize,
          orderBy: 'likes_count', orderDirection: 'desc'
        }
      });

      return result.map(u => {
        u.updated_at = new Date(u.updated_at).valueOf();
        return u;
      });
    },

    user: async (_, { id }, context) => {
      try {
        const user = await context.app.knex('users')
          .where({ id })
          .first();

        if (user?.updated_at)
          user.updated_at = new Date(user.updated_at).valueOf();
        context.app.pubsub.publish(context);

        return user;
      } catch (error) {
        console.error(error);
        throw new Error('Failed to retrieve user by ID');
      }
    },
  },

  Mutation: {
    auth: async (_, args, { app }) => {
      const knex = app.knex;

      const [user] = await knex('users')
        .insert({
          role: 'user',
          name: args.user.name,
          email: args.user.email,
          image: args.user.image.split('=')[0],
          provider: args.account.provider,
          password: app.bcrypt.encrypt(args.account.provider)
        })
        .onConflict('email')
        .merge(['name', 'image', 'provider'])
        .returning('*');

      const token = await app.crypto.token();

      await knex('sessions')
        .insert({
          user_id: user.id,
          access_token: app.crypto.hash(token),
          expired_at: new Date(Date.now() + 3600000) // after 1 hour
        });

      return { user, token };
    },

    follow: async (_, args, { app, current_user }) => {
      if (!current_user)
        throw new Error('Only logged in user can follow');

      const { knex } = app;
      const { userId } = args;

      const user = await knex('users').where({ id: userId }).first();
      if (!user)
        throw new Error('User not found');

      if (!user.status) {
        if (current_user.role !== 'admin')
          throw new Error('User is not active');
      }

      let followerId = null;
      if (current_user.role === 'admin')
        followerId = args.followerId;

      if (!followerId)
        followerId = current_user.id;

      if (userId.toString() === followerId.toString()) {
        // return await knex('users').where({ id: userId }).first();
        throw new Error("You can't follow yourself");
      }

      // check if already follow
      const record = await knex('users_followers').where({ user_id: userId, follower_id: followerId }).first();
      if (!record)
        await knex('users_followers').insert({ user_id: userId, follower_id: followerId });

      return knex('users').where({ id: userId }).first();
    },

    unfollow: async (_, args, { app, current_user }) => {
      if (!current_user)
        throw new Error('Only logged in user can unfollow');

      const { knex } = app;
      const { userId } = args;

      const user = await knex('users').where({ id: userId }).first();
      if (!user)
        throw new Error('User not found');

      if (!user.status) {
        if (current_user.role !== 'admin')
          throw new Error('User is not active');
      }

      let followerId = null;
      if (current_user.role === 'admin')
        followerId = args.followerId;

      if (!followerId)
        followerId = current_user.id;

      if (userId.toString() === followerId.toString()) {
        // return await knex('users').where({ id: userId }).first();
        throw new Error("You can't unfollow yourself");
      }

      await knex('users_followers')
        .where({ user_id: userId, follower_id: followerId })
        .del();

      return knex('users').where({ id: userId }).first();
    },

    toggleStatusUser: (_, args, { app, current_user }) => {
      if (!current_user || current_user.role !== 'admin')
        throw new Error("Only admin can update user's status");

      return helpers.toggleStatus(app.knex, {
        tableName: 'users', idField: 'id',
        id: args.userId, status: args.active,
        entityName: 'User'
      });
    },
  },
}
