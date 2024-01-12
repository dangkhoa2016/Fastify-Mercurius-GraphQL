'use strict';
const helpers = require('../../libs/helpers');

module.exports = {
  Query: {
    photos: (_, { pageIndex, pageSize = 10 }, { app, current_user }) => {
      // console.log('pageIndex', pageIndex);
      // console.log('pageSize', pageSize);

      const filter = { };
      if (!current_user || current_user.role !== 'admin')
        filter['photos.status'] = true;

      return helpers.getWithPagination(app.knex, { tableName: 'photos', conditions: filter, options: { pageIndex, pageSize } });
    },

    photo: async (_, { id }, context) => {
      const { current_user } = context;

      const photo = await context.app.knex('photos')
        .where({ id })
        .first();

      if (!photo)
        throw new Error('Photo not found');

      if (!photo.status) {
        const user = await context.app.knex('users').join('cats', 'cats.user_id', 'users.id').where('cats.id', photo.cat_id).first('users.*');
        if (!current_user || (current_user.role !== 'admin' && user && user.id.toString() !== current_user.id.toString()))
          throw new Error('Photo is not active');
      }

      context.app.pubsub.publish(context);

      return photo;
    },

    photosByCatId: async (_, { catId, pageIndex, pageSize = 10 }, { app, current_user }) => {
      const { knex } = app;
      // console.log('pageIndex', pageIndex);
      // console.log('pageSize', pageSize);
      // console.log('catId', catId);
      const filter = { cat_id: catId };

      // verify cat is active
      const cat = await knex('cats').where({ id: catId }).first();
      if (!cat)
        throw new Error('The cat that these photos belong to is not found');

      if (!cat.status) {
        if (!current_user || (current_user.role !== 'admin' && cat.user_id.toString() !== current_user.id.toString()))
          throw new Error('The cat that these photos belong to is not active');
      }

      const is_current_user_request = current_user && current_user.id.toString() === cat.user_id.toString();
      if (!current_user || (current_user.role !== 'admin' && !is_current_user_request))
        filter['photos.status'] = true;

      return helpers.getWithPagination(knex, {
        tableName: 'photos', conditions: filter,
        options: { pageIndex, pageSize }
      });
    },

    photosByUserId: async (_, { userId, pageIndex, pageSize = 10 }, { app, current_user }) => {
      const { knex } = app;
      // console.log('pageIndex', pageIndex);
      // console.log('pageSize', pageSize);
      // console.log('userId', userId);
      const filter_cats = {};
      const filter_photos = {};

      const is_current_user_request = current_user && current_user.id.toString() === userId.toString();
      if (!current_user || (current_user.role !== 'admin' && !is_current_user_request)) {
        filter_photos['photos.status'] = true;
        filter_cats['cats.status'] = true;
      }

      let query = knex('cats').select('id').where({ user_id: userId });
      if (Object.keys(filter_cats).length)
        query = query.where(filter_cats);
      const cat_ids = await query;
      filter_photos.cat_id = cat_ids.map(({ id }) => id);

      return helpers.getWithPagination(knex, {
        tableName: 'photos', conditions: filter_photos,
        options: { pageIndex, pageSize }
      });
    },
  },

  Mutation: {
    updateLikePhoto: async (_, args, { app, current_user }) => {
      if (!current_user)
        throw new Error(`Only logged in user can ${args.like ? 'like' : 'unlike'} a photo`);

      const { knex } = app;
      const updateAction = args.like ? 'likes_count + 1' : 'likes_count - 1';

      let photo = await knex('photos').where({ id: args.photoId }).first();
      if (!photo)
        throw new Error('Photo not found');

      if (!photo.status) {
        if (current_user.role !== 'admin')
          throw new Error('Photo is not active');
      }

      const cat = await knex('cats').where({ id: photo.cat_id }).first();
      if (!cat)
        throw new Error('The cat that this photo belongs to is not found');

      if (!cat.status) {
        if (current_user.role !== 'admin' && cat.user_id.toString() !== current_user.id.toString())
          throw new Error('The cat that this photo belongs to is not active');
      }

      if (cat.user_id.toString() === current_user.id.toString())
        throw new Error(`You can't ${args.like ? 'like' : 'unlike'} your own photo`);

      photo = await knex('photos')
        .where({ id: args.photoId })
        .update({ likes_count: knex.raw(updateAction) })
        .returning('*');


      // update user like count
      await knex('users')
        .where({ id: cat.user_id })
        .update({ likes_count: knex.raw(updateAction) });

      return photo[0];
    },

    toggleStatusPhoto: (_, args, context) => {
      if (!context.current_user || context.current_user.role !== 'admin')
        throw new Error("Only admin can update photo's status");

      return helpers.toggleStatus(context.app.knex, {
        tableName: 'photos', idField: 'id',
        id: args.photoId, status: args.active,
        entityName: 'Photo'
      });
    },
  },
};
