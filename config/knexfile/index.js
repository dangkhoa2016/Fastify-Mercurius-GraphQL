module.exports = {
  development: {
    client: 'pg',
    connection: {
      host: 'localhost',
      user: 'postgres',
      password: '123456',
      database: 'animals'
    }
  },

  production: {
    client: 'pg',
    connection: {
      host: '',
      user: '',
      password: '',
      database: ''
    },
    pool: {
      min: 5,
      max: 15
    },
    migrations: {
      tableName: 'knex_migrations'
    },
    ssl: {
      rejectUnauthorized: false
    }
  }
}