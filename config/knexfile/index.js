const path = require('path');
const root_dir = path.resolve(__dirname, '../../');
require('dotenv').config({ path: path.resolve(root_dir, '.env'), debug: process.env.DEBUG });

const { DB_FOLDER } = process.env;
if (!DB_FOLDER) {
  throw new Error('DB_FOLDER is not defined in .env file');
}

const DB_NAME = 'mercurius-graphql';

const getDBPath = (envName) => {
  if (!envName) {
    envName = 'development';
  }
  if (envName === 'production')
    envName = '';
  else
    envName = `_${envName}`;
  return path.resolve(root_dir, `${DB_FOLDER}/${DB_NAME}${envName}.db`);
}

module.exports = {
  development: {
    client: 'better-sqlite3', // or 'sqlite3',
    connection: {
      filename: getDBPath(),
      options: {
      },
    },
    debug: true,
    useNullAsDefault: true,
    // migrations: {
    //   directory: path.resolve(__dirname, '../migrations'),
    // },
    // seeds: {
    //   directory: path.resolve(__dirname, '../seeds'),
    // },
  },

  production: {
    client: 'better-sqlite3', // or 'sqlite3',
    connection: {
      filename: getDBPath('production'),
    },
    useNullAsDefault: true,
  },

  test: {
    client: 'better-sqlite3', // or'sqlite3',
    connection: {
      filename: getDBPath('test'),
    },
    useNullAsDefault: true,
    // migrations: {
    //   directory: path.resolve(__dirname, '../migrations'),
    // },
    // seeds: {
    //   directory: path.resolve(__dirname, '../seeds'),
    // },
  }
}
