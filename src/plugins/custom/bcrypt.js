'use strict'

const bcrypt = require('bcrypt');

const fp = require('fastify-plugin')


const plugin = (app, opts, done) => {

  const salt = bcrypt.genSaltSync(opts.salt)

  app.decorate('bcrypt', {
    encrypt: (password) => {
      return bcrypt.hashSync(password, salt)
    },
    compare: (password, hash) => { 
      return bcrypt.compareSync(password, hash)
    }
  });

	done();

}

module.exports = fp((app, opts, done) => {

  app.register(fp(plugin), { salt: 10 })

  done();

})
