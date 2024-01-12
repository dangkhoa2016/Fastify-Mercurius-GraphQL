'use strict';
const helpers = require('../../libs/helpers');

module.exports = {
  User: {
    cats_count: async (users, { app, current_user }) => {
      const { knex } = app;

      const filter = { };
      const is_current_user_request = current_user && users.length === 1 && current_user.id.toString() === users[0].obj.id.toString();
      if (!current_user || (current_user.role !== 'admin' && !is_current_user_request))
        filter['cats.status'] = true;

      const result = await helpers.getCounts(knex, {
        items: users,
        groupFieldName: 'userId',
        foreignKeyName: 'user_id',
        tableName: 'users',
        filter, countField: 'cats.id',
        relatedTableName: 'cats',
      });

      return users.map(({ obj }) => {
        return (result.find(record => record[obj.id]) ?? {})[obj.id] ?? 0;
      });
    },

    photos_count: async (users, { app, current_user }) => {
      const { knex } = app;

      const filter_cats = { };
      const filter_photos = { };
      const is_current_user_request = current_user && users.length === 1 && current_user.id.toString() === users[0].obj.id.toString();
      if (!current_user || (current_user.role !== 'admin' && !is_current_user_request)) {
        filter_cats['cats.status'] = true;
        filter_photos['photos.status'] = true;
      }

      const user_ids = users.map(({ obj }) => obj.id);
      let query = knex('cats').select('user_id', 'id').whereIn('user_id', user_ids);
      if (Object.keys(filter_cats).length > 0)
        query = query.where(filter_cats);
      const mapping = await query;
      const cats = mapping.map(({ id }) => ({ obj: { id } }));

      const result = await helpers.getCounts(knex, {
        items: cats, filter: filter_photos,
        groupFieldName: 'catId',
        foreignKeyName: 'cat_id',
        tableName: 'cats', countField: 'photos.id',
        relatedTableName: 'photos',
      });

      return user_ids.map(uid => {
        let count = 0;
        const cat_ids = mapping.filter(({ user_id }) => user_id === uid).map(({ id }) => id);

        cat_ids.forEach(cat_id => {
          count += (result.find(record => record[cat_id]) ?? {})[cat_id] ?? 0;
        });

        return count;
      });
    },

    followers_count: async (users, { app, current_user }) => {
      const { knex } = app;

      const filter = { };
      const is_current_user_request = current_user && users.length === 1 && current_user.id.toString() === users[0].obj.id.toString();
      if (!current_user || (current_user.role !== 'admin' && !is_current_user_request))
        filter.status = true;

      const result = await helpers.getCounts(knex, {
        items: users,
        groupFieldName: 'userId',
        foreignKeyName: 'user_id',
        tableName: 'users', filter,
        countField: '*',
        relatedTableName: 'users_followers',
      });

      return users.map(({ obj }) => {
        return (result.find(record => record[obj.id]) ?? {})[obj.id] ?? 0;
      });
    },

    followed: async (users, { app, current_user }) => {
      const user_ids = users.map(({ obj }) => obj.id);

      if (!current_user) {
        const result = user_ids.map(() => false);
        return result;
      } else if (users.length === 1 && current_user.id === users[0].obj.id)
        return [true];

      const { knex } = app;

      const query = knex('users_followers').select('user_id')
        .where('follower_id', current_user.id).whereIn('user_id', user_ids);
      let followers = await query;

      followers = user_ids.map(id => (followers.findIndex(follower => follower.user_id === id) !== -1 ? true : false));

      return followers;
    },

    country: async (users, { app }) => {
      const user_ids = users.map(({ obj }) => obj.id);
      const { knex } = app;

      const mapping = await knex('users').select('country_id', 'id').whereIn('id', user_ids).distinct();

      const country_ids = mapping.map(({ country_id }) => country_id);
      // console.log('country_ids', country_ids);
      const countries = await knex('countries').select('name', 'id').whereIn('id', country_ids);
      // console.log('countries', countries);

      return user_ids.map(id => {
        const country_id = mapping.find(mapp => mapp.id === id).country_id;
        return (countries.find(country => country.id === country_id) || {}).name;
      });
    }
  },
};
