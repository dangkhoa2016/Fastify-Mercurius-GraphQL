'use strict';

const fp = require('fastify-plugin');

const auth = require('mercurius-auth');

const skipCheck = (info) => {
	return (
		(info.fieldName === 'users' && info.returnType.name === 'UserPage') ||
		info.fieldName === 'topUsersByLikeCount' ||
		(info.fieldName === 'user' && info.returnType.name === 'User')
	);
};

module.exports = fp((app, opts, done) => {
	app.register(auth, {
		authContext(context) {
			return {
				identity: context.reply.request.headers['x-access-token'],
			};
		},
		async applyPolicy(_auth, parent, args, context, info) {
			const isSkip = skipCheck(info);
			if (!context.auth.identity) {
				// console.log('info.fieldName', info.fieldName);
				// console.log('info.returnType', info.returnType);
				if (isSkip) return true;

				throw new Error('Unauthenticated.');
			}

			// console.log('session id', context.auth.identity);
			const encryptedToken = context.app.crypto.hash(context.auth.identity);
			// console.log('encryptedToken', encryptedToken);
			const session = await context.app
				.knex('sessions')
				.select('users.id', 'users.role', 'users.status', 'expired_at')
				.innerJoin('users', (knex) => {
					knex
						.on('users.id', 'sessions.user_id')
						.on('users.status', context.app.knex.raw('?', [true]));
				})
				.where({
					access_token: encryptedToken,
					is_revoked: false,
				})
				.first();

			// console.log('applyPolicy: session', session);

			if (!session) {
				if (isSkip) return true;
				throw new Error('Session was not found.');
			}

			// console.log('session.expired_at', session.expired_at, (new Date()).valueOf());
			if (session.expired_at < new Date().valueOf())
				throw new Error('Session was expired.');

			delete session.expired_at;
			context.current_user = session;

			return true;
		},

		authDirective: 'auth',
	});

	done();
});
