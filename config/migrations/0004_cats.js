exports.up = function (knex) {
  return knex.schema.createTable('cats', (table) => {
    table.increments('id').index()
    table.string('name', 255).notNullable()
    table.string('image', 255).notNullable()
    table.string('description', 255)
    table.string('coat_color', 255)
    table.string('eye_color', 255)
    table.string('breed', 255)
    table.string('origin', 255)
    table.float('weight', 255)
    table.float('height', 255)
    table.string('gender', 50)
    table.date('birthday')
    table.boolean('status').notNullable().defaultTo(true)
    table
      .integer('user_id')
      .unsigned()
      .references('users.id')
      .notNullable()
      .index()
      .onDelete('CASCADE')
    table.integer('likes_count').defaultTo(0)

    table.timestamps(false, true)
  })
}

exports.down = (knex) => {
  return knex.schema.dropTable('cats')
}
