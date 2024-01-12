'use strict'
const invalidLoginMessage = 'Incorrect username or password.';

const extractFields = (user) => {
  return {
    id: user.id,
    name: user.name,
    email: user.email,
    image: user.image,
    role: user.role,
    status: user.status,
    created_at: user.created_at,
    updated_at: user.updated_at
  };
};

module.exports = {
  Mutation: {
    login: async (_, { email, password }, context) => {
      const { knex } = context.app;
      const user = await knex('users')
        .where(knex.raw('LOWER(??)', ['email']), email.toLowerCase())
        .first();

      if (!user)
        return new Error(invalidLoginMessage);

      if (!user.status)
        return new Error('Your account is not active');

      const isValidPassword = context.app.bcrypt.compare(password, user.password);

      if (!isValidPassword)
        return new Error(invalidLoginMessage);

      const token = await context.app.crypto.token();
      const userToken = await context.app.crypto.encrypt(JSON.stringify({ id: user.id, token }));

      await knex('sessions')
        .insert({
          user_id: user.id,
          access_token: context.app.crypto.hash(token),
          expired_at: new Date(Date.now() + 3600000) // after 1 hour
        });

      return {
        user: extractFields(user),
        token, userToken
      };
    },

    decryptUserToken: async (_, { userToken }, { app }) => {
      try {
        const decrypted = app.crypto.decrypt(userToken);
        const { id, token } = JSON.parse(decrypted);
        const user = await app.knex('users').where({ id }).first();
        if (!user)
          throw new Error('User not found');
        if (!user.status)
          throw new Error('User is not active');

        return {
          user: extractFields(user),
          token
        };
      } catch (error) {
        console.error(error);
        throw new Error('Failed to decrypt user token.');
      }
    },

    changePassword: async (_, { password }, context) => {
      await context.app.knex('users')
        .update({ password: context.app.bcrypt.encrypt(password) })
        .where('id', context.current_user.id);

      return true
    },
  }
}
