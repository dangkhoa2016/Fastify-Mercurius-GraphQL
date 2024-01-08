'use strict'

const fp = require('fastify-plugin')

const auth = require('mercurius-auth')

module.exports = fp(async (app) => {
  app.register(auth, {
    authContext(context) {
      return {
        identity: context.reply.request.headers['x-access-token']
      }
    },
    async applyPolicy(auth, parent, args, context) {

      if (!context.auth.identity) {
        throw new Error('Unauthenticated.')
      }

      console.log('session id', context.auth.identity);
      const encryptedToken = context.app.crypto.hash(context.auth.identity);
      console.log('encryptedToken', encryptedToken);
      const session = await context.app.knex('sessions')
        .select('users.id', 'users.role', 'users.status')
        .innerJoin('users', (knex) => {
          knex.on('users.id', 'sessions.user_id').on('users.status', context.app.knex.raw('?', [true]))
        })
        .where({ access_token: encryptedToken, is_revoked: false })
        .first()

      console.log('session', session);

      if (session) {
        context.current_user = session

        return true;
      }

      else throw new Error('Session was not found.');
    },

    authDirective: 'auth'
  })
})
