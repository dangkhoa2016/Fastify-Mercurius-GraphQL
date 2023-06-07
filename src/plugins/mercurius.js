'use strict'

const fp = require('fastify-plugin')

const mercurius = require('mercurius')

const { resolve } = require('path')

const { typeDefs, composedResolvers, loaders } = require(resolve('src/graphql/tools'))

const { directiveResolvers } = require(resolve('src/graphql/directives'))

const { makeExecutableSchema } = require('@graphql-tools/schema')

const schema = makeExecutableSchema({
  typeDefs,
  resolvers: composedResolvers,
  directiveResolvers
})

module.exports = fp(async (app) => {
  app.register(mercurius, {
    schema,
    loaders: loaders,
    subscription: true,
    graphiql: true
  })
})
