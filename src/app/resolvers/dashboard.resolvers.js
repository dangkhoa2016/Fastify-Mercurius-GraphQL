'use strict';
const helpers = require('../../libs/helpers');

module.exports = {
  Query: {
    counters: (_, __, { app, current_user }) => {
      return helpers.fetchCounters(app.knex, current_user && current_user.role === 'admin');
    },

    userFields: (_, __, context) => {
      const { app: { graphql: { schema } } } = context;
      const availableFields = helpers.getFields('User', schema);
      return availableFields;
    },

    catFields: (_, __, context) => {
      const { app: { graphql: { schema } } } = context;
      const availableFields = helpers.getFields('Cat', schema);
      return availableFields;
    },

    photoFields: (_, __, context) => {
      const { app: { graphql: { schema } } } = context;
      const availableFields = helpers.getFields('Photo', schema);
      return availableFields;
    },

    catsGroupByUsers: (_, __, { app, current_user }) => {
      return helpers.fetchGroupedByField(app.knex, {
        isAdmin: current_user && current_user.role === 'admin',
        tableName: 'cats', joinTable: 'users',
        joinKey: 'users.id', referenceKey: 'user_id'
      });
    },

    photosGroupByCats: (_, __, { app, current_user }) => {
      return helpers.fetchGroupedByField(app.knex, {
        isAdmin: current_user && current_user.role === 'admin',
        tableName: 'photos', joinTable: 'cats',
        joinKey: 'cats.id', referenceKey: 'cat_id'
      });
    },
  },
};
