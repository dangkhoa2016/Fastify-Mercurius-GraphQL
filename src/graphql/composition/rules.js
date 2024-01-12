'use strict'

const hasRole = (role) => next => (parent, args, context, info) => {

  if (!context.app.current_user || context.app.current_user.role.includes(role)) {
    return next(parent, args, context, info);
  }

  throw new Error('You are not authorized to do this action.')

}

module.exports = {
  hasRole
}
