'use strict'

const fp = require('fastify-plugin')

const mercurius = require('mercurius')

const { resolve } = require('path')

const { typeDefs, composedResolvers, loaders } = require(resolve('src/graphql/tools'))

const { redactionSchemaTransformer } = require(resolve('src/graphql/directives'))

const { makeExecutableSchema } = require('@graphql-tools/schema')

const directiveTransformers = [redactionSchemaTransformer]

const executableSchema = makeExecutableSchema({
  typeDefs,
  resolvers: composedResolvers
})

const schema = directiveTransformers.reduce((curSchema, transformer) => transformer(curSchema), executableSchema)

module.exports = fp(async (app) => {
  app.register(mercurius, {
    schema,
    loaders,
    subscription: true,
    graphiql: true
  })
})
