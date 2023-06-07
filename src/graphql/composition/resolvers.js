'use strict'

const { resolve } = require('path')

const { hasRole } = require(resolve('src/graphql/composition/rules'))

const resolversComposition = {
  'Query.users': [hasRole('admin')]
}

module.exports = resolversComposition