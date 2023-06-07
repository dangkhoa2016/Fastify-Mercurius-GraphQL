'use strict'

const { loadFilesSync } = require('@graphql-tools/load-files')
const { mergeTypeDefs, mergeResolvers } = require('@graphql-tools/merge')
const { composeResolvers } = require('@graphql-tools/resolvers-composition')

const { resolve } = require('path')

const typeDefs = mergeTypeDefs(loadFilesSync(resolve('src/graphql/schemas'), { extensions: ['graphql'] }))
const resolvers = mergeResolvers(loadFilesSync(resolve('src/graphql/resolvers', '*.resolvers.*')))
const loaders = mergeResolvers(loadFilesSync(resolve('src/graphql/loaders', '*.loaders.*')))

const resolversComposition = require(resolve('src/graphql/composition/resolvers'))

const composedResolvers = composeResolvers(resolvers, resolversComposition)

module.exports = {
  typeDefs, composedResolvers, loaders
}