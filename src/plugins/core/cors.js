'use strict'

const fp = require('fastify-plugin')

module.exports = fp((app, opts, done) => {

  app.register(require('@fastify/cors'), {
    origin: true
  });

  done();

});
