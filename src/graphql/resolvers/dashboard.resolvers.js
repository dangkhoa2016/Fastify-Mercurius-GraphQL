'use strict'

module.exports = {
  Query: {
    counters: async (_, __, context) => {

      try {

        const knex = context.app.knex

        const [counters] = await knex.from(knex.raw('cats c, users u'))
          .countDistinct('u.id as users')
          .countDistinct('c.id as cats')

        return counters

      } catch (e) {

        return new Error(e)
      }

    }
  }
}