'use strict';
const path = require('path');
require('dotenv').config({
	path: path.resolve('.', '.env'),
	debug: process.env.DEBUG,
});

const { PORT } = process.env;

const fastify = require('fastify');

const autoload = require('@fastify/autoload');

const { join, resolve } = require('path');

const app = fastify({
	logger: true,
});

app.register(autoload, {
	dir: join(resolve('src/plugins')),
});

app.register(autoload, {
	dir: join(resolve('src/auth')),
});

app.get('/', (/* req, reply */) => {
	return { hello: 'world' };
});

app.listen({ port: PORT ?? 4000, host: '0.0.0.0' });
