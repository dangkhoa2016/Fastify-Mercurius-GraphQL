async function checkIfTableExists(knex, tableName) {
	const tableExists = await knex.schema.hasTable(tableName);
	// console.log(`Table '${tableName}' exists: ${tableExists}`);
	return tableExists;
}

async function addLikeCount(knex, tableName) {
	const ids = (await knex.select('id').from(tableName)).map((row) => row.id);
	for (const id of ids) {
		const count = Math.floor(Math.random() * 100) + 1;
		await knex(tableName).where({ id }).update({ likes_count: count });
	}
}

async function updateLikeCountForUsers(knex) {
	const user_ids = (await knex.select('id').from('users')).map((row) => row.id);
	for (const user_id of user_ids) {
		const cat_ids = (
			await knex.select('id').from('cats').where({ user_id })
		).map((row) => row.id);
		const countCatLikes = await knex
			.sum('likes_count as sum_likes_count')
			.from('cats')
			.whereIn('id', cat_ids);
		const countPhotoLikes = await knex
			.sum('likes_count as sum_likes_count')
			.from('photos')
			.whereIn('cat_id', cat_ids);

		const likes_count =
			countCatLikes[0].sum_likes_count + countPhotoLikes[0].sum_likes_count;
		await knex('users').where({ id: user_id }).update({ likes_count });
	}
}

exports.seed = async function (knex) {
	// await knex.raw('TRUNCATE TABLE photos RESTART IDENTITY CASCADE');
	let isTableExists = await checkIfTableExists(knex, 'cats');
	if (isTableExists) {
		// add like counts for cats
		await addLikeCount(knex, 'cats');
	}

	isTableExists = await checkIfTableExists(knex, 'photos');
	if (isTableExists) {
		// add like counts for photos
		await addLikeCount(knex, 'photos');
	}

	await updateLikeCountForUsers(knex);
};
