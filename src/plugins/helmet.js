'use strict'

const fp = require('fastify-plugin')

const { env } = require('process')

module.exports = fp(async (app) => {
  app.register(require('@fastify/helmet'), { contentSecurityPolicy: env.NODE_ENV === 'production' })
})
