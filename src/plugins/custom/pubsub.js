'use strict';

const fp = require('fastify-plugin')

module.exports = fp((app, opts, done) => {

  app.decorate('pubsub', {
    publish: async (context) => {
      await context.pubsub.publish({
        topic: 'NOTIFICATION',
        payload: {
          notification: { message: 'Uma nova notificação' }
        }
      })
    }
  });

  done();

})
