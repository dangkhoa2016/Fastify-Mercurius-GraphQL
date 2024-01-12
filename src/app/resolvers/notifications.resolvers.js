'use strict'

module.exports = {
  Subscription: {
    notification: {
      subscribe: (_, __, { pubsub }) => {
        return pubsub.subscribe('NOTIFICATION')
      },
    },
  },
}
