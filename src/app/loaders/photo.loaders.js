'use strict'
const helpers = require('../../libs/helpers');

module.exports = {
  Photo: {
    cat: async (photos, context) => {
      const result = await helpers.fetchOwners(context.app.knex, {
        tableName: 'photos', idField: 'cat_id',
        relatedTableName: 'cats', records: photos,
        selectFields: ['cats.id', 'cats.name', 'cats.likes_count']
      });

      return photos.map(({ obj }) => result.find(record => record.cat_id === obj.cat_id) || {});
    },
    owner: async (photos, context) => {
      const result = await helpers.fetchOwners(context.app.knex, {
        tableName: 'photos', idField: 'cat_id',
        relatedTableName: 'cats', records: photos,
        selectFields: ['cats.user_id', 'cats.name', 'cats.likes_count']
      });

      const result2 = photos.map(({ obj }) => result.find(record => record.cat_id === obj.cat_id) || {});
      const users = await context.app.knex('users').select('id', 'name', 'likes_count')
        .whereIn('id', result2.map(record => record.user_id)).distinct();
      // console.log('users', users);
      const result3 = result2.map(record => {
        return users.find(user => user.id === record.user_id) || {};
      });
      // console.log('result3', result3);
      return result3;
    },
  },
}
