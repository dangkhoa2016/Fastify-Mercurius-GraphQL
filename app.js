'use strict'

const fastify = require('fastify')

const autoload = require('@fastify/autoload')

const { join, resolve } = require('path')

const app = fastify({
  logger: true
})

app.register(autoload, {
  dir: join(resolve('src/plugins'))
})

app.register(autoload, {
  dir: join(resolve('src/auth'))
})

app.listen({ port: 4000, host: '0.0.0.0' })