
exports.up = function (knex) {
  return knex.schema.createTable('users_followers', (table) => {
    table
      .integer('user_id')
      .unsigned()
      .references('users.id')
      .notNullable()
      .index()
      .onDelete('CASCADE')
    table
      .integer('follower_id')
      .unsigned()
      .references('users.id')
      .notNullable()
      .index()
      .onDelete('CASCADE')

    table.unique(['user_id', 'follower_id']);
    table.timestamps(false, true)
  });
}

exports.down = (knex) => {
  return knex.schema.dropTable('users_followers');
}
