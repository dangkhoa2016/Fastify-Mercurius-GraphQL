'use strict'

const fp = require('fastify-plugin');

const path = require('path');

module.exports = fp((app, opts, done) => {

  app.register(require('@fastify/static'), {
    root: path.resolve('public'),
    prefix: '/public'
  });

  done();

});
