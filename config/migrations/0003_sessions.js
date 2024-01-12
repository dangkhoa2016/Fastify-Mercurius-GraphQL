
exports.up = function (knex) {
  return knex.schema.createTable('sessions', (table) => {
    table.increments('id')
    table
      .integer('user_id')
      .unsigned()
      .references('users.id')
      .notNullable()
      .index()
      .onDelete('CASCADE')

    table.text('access_token').index()
    table.boolean('is_revoked').index().defaultTo(false)

    // Add expired_at column
    table.timestamp('expired_at').index();
    table.timestamps(false, true)
  })
}

exports.down = (knex) => {
  return knex.schema.dropTable('sessions')
}
