'use strict'

module.exports = {
  Mutation: {
    login: async (_, { email, password }, context) => {

      const user = await context.app.knex('users')
        .where({ email: email, status: true })
        .first()

      if (user) {

        const compare = context.app.bcrypt.compare(password, user.password)

        if (compare) {

          const token = await context.app.crypto.token()

          await context.app.knex('sessions')
            .insert({ user_id: user.id, access_token: context.app.crypto.hash(token) })

          return { user, token }
        }

      }

      return new Error('Incorrect username or password')

    },

    change_password: async (_, { password }, context) => {

      await context.app.knex('users')
        .update({ password: context.app.bcrypt.encrypt(password) })
        .where('id', context.current_user.id)

      return true
    }
  }
}
