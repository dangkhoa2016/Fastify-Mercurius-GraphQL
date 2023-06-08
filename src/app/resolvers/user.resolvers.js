'use strict'

module.exports = {
  Query: {
    users: async (_, __, context) => {
      const users = await context.app.knex('users')

      context.app.pubsub.publish(context)

      return users
    }
  },

  Mutation: {
    auth: async (_, args, context) => {

      const knex = context.app.knex

      const [user] = await knex('users')
        .insert({
          name: args.user.name,
          email: args.user.email,
          image: args.user.image.split('=')[0],
          provider: args.account.provider
        })
        .onConflict('email')
        .merge(['name', 'image', 'provider'])
        .returning('*')


      const token = await context.app.crypto.token()

      await knex('sessions')
        .insert({
          user_id: user.id,
          access_token: context.app.crypto.hash(token)
        })

      return { user, token }
    }
  }
}
