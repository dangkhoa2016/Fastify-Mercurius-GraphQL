'use strict';

const fp = require('fastify-plugin');

const crypto = require('crypto');
const { SALT_KEY, ENCRYPT_KEY, } = process.env;

const plugin = (app, opts, done) => {

  app.decorate('crypto', {
    token: () => {
      return new Promise((resolve) => {
        crypto.randomBytes(32, (_, data) => {
          resolve(data.toString('base64'));
        });
      });
    },

    hash: (token) => {
      return crypto.createHmac('sha512', opts.salt).update(token).digest('base64')
    },

    encrypt,

    decrypt,
  })

  const config = Object.values({
    algorithm: 'aes-192-ecb',
    key: ENCRYPT_KEY,
    init: null
  })

  function encrypt(data) {
    const cipher = crypto.createCipheriv(...config)

    return cipher
      .update(data, 'utf8', 'base64')
      .concat(cipher.final('base64'));
  }

  function decrypt(data) {
    const decipher = crypto.createDecipheriv(...config)

    return decipher
      .update(data, 'base64', 'utf8')
      .concat(decipher.final('utf8'));
  }

	done();

}

module.exports = fp((app, opts, done) => {

  app.register(fp(plugin), { salt: SALT_KEY })

  done();

})
