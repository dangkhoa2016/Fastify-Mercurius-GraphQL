'use strict'

module.exports = {
  Subscription: {
    notification: {
      subscribe: async (_, __, { pubsub }) => {
        return await pubsub.subscribe('NOTIFICATION')
      }
    }
  }
}
