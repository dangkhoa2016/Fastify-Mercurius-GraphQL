'use strict'

const bcrypt = require('bcrypt');

const fp = require('fastify-plugin')


const plugin = async (app, opts) => {
  const salt = bcrypt.genSaltSync(opts.salt)

  app.decorate('bcrypt', {
    encrypt: (password) => {
      return bcrypt.hashSync(password, salt)
    },
    compare: (password, hash) => { 
      return bcrypt.compareSync(password, hash)
    }
  });

}

module.exports = fp(async (app) => {
  app.register(fp(plugin), { salt: 10 })
})
