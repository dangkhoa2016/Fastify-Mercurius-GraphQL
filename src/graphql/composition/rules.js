'use strict'

const hasRole = (role) => next => (parent, args, context, info) => {

  if (!context.app.current_user || context.app.current_user.role.includes(role)) {

    return next(parent, args, context, info)
  }

  throw new Error('Você não tem autorização para isso')

}

module.exports = {
  hasRole
}
