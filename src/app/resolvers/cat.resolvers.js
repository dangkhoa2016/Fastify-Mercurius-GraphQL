'use strict'

module.exports = {
  Query: {
    cats: async (_, __, context) => {
      return await context.app.knex('cats').orderBy('cats.id', 'asc')
    }
  }
}
