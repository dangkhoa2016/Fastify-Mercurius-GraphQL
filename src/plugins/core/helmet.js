'use strict'

const fp = require('fastify-plugin');

const { env } = require('process');

module.exports = fp((app, opts, done) => {

  app.register(require('@fastify/helmet'), { contentSecurityPolicy: env.NODE_ENV === 'production' });

  done();

});
