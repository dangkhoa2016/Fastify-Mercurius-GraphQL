exports.up = function (knex) {
  return knex.schema.createTable('photos', (table) => {
    table.increments('id').index();
    table.string('title', 255).notNullable().index();
    table.string('description', 455);
    table.boolean('status').notNullable().defaultTo(true)
    table.integer('cat_id').notNullable().index().references('cats.id').onDelete('CASCADE');
    table.string('url', 455).notNullable();
    table.integer('likes_count').defaultTo(0);

    table.timestamps(false, true);
  })
}

exports.down = (knex) => {
  return knex.schema.dropTable('photos');
}
