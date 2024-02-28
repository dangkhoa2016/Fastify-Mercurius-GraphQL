'use strict';

const fp = require('fastify-plugin');

module.exports = fp((app, opts, done) => {
	app.register(require('@fastify/rate-limit'), {
		max: 1000,
		ban: 100,
		timeWindow: '10m',
		errorResponseBuilder: () => ({
			statusCode: 429,
			error: 'Too many requests',
			message: 'Rate limit exceeded, please try again later',
		}),
	});

	done();
});
