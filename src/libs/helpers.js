'use strict';

const { GraphQLObjectType } = require('graphql');
const hasStatusColumnTables = ['cats', 'photos', 'users'];

const getWithPagination = async (knex, { tableName, conditions, options = {} }) => {
  const {
    pageIndex = 1,
    pageSize = 10,
    orderBy = 'id',
    orderDirection = 'asc',
    onlyItems = false,
  } = options;

  const offset = (pageIndex - 1) * pageSize;

  try {
    let query = knex(tableName);
    if (conditions && Object.keys(conditions).length) {
      for (const [key, value] of Object.entries(conditions)) {
        if (Array.isArray(value))
          query = query.whereIn(key, value);
        else
          query = query.where(key, value);
      }
    }

    if (onlyItems) {
      return await query
        .orderBy(orderBy, orderDirection)
        .limit(pageSize)
        .offset(offset);
    }

    const [records, countData] = await Promise.all([
      query.clone()
        .orderBy(orderBy, orderDirection)
        .limit(pageSize)
        .offset(offset),

      query
        .count('id as countName')
        .first(),
    ]);

    const { countName } = countData;

    const total_pages = Math.ceil(countName / pageSize);

    return {
      items: records,
      total_items: countName,
      total_pages,
    };
  } catch (error) {
    console.error(`Error retrieving ${tableName} with pagination:`, error);
    throw error;
  }
};

const getFields = (typeName, schema) => {
  const dataType = schema._typeMap[typeName];
  return dataType instanceof GraphQLObjectType ? Object.keys(dataType.getFields()) : [];
};

const listTables = async (knex) => {
  try {
    const result = await knex.raw("SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE '%knex_%' AND name != 'sqlite_sequence';");
    const tableNames = result.map(row => row.name);
    // console.log('Tables:', tableNames);
    return tableNames;
  } catch (error) {
    console.error('Error listing tables:', error);
    throw error;
  }
};

const countRowsForTable = async (knex, tableName, isAdmin = false) => {
  try {
    let query = knex(tableName);
    if (!isAdmin && hasStatusColumnTables.includes(tableName)) {
      query = query.where('status', 1);
    }
    const [{ count }] = await query.count('* as count');
    return { tableName, count };
  } catch (error) {
    console.error(`Error counting rows for table ${tableName}:`, error);
    throw error;
  }
};

const countRowsForTables = async (knex, tableNames, isAdmin = false) => {
  try {
    const rowCountPromises = tableNames.map(tableName => countRowsForTable(knex, tableName, isAdmin));
    return await Promise.all(rowCountPromises);
  } catch (error) {
    console.error('Error counting rows for tables:', error);
    throw error;
  }
};

const fetchCounters = async (knex, isAdmin = false) => {
  try {
    const tableNames = await listTables(knex);
    const result = await countRowsForTables(knex, tableNames, isAdmin);
    // console.log('Row counts for each table:', result);
    return result.reduce((acc, { tableName, count }) => {
      acc[tableName] = count;
      return acc;
    }, {});
  } catch (error) {
    console.error('Error fetching counters:', error);
    throw error;
  }
};

const fetchGroupedByField = async (knex, { isAdmin, tableName, joinTable, referenceKey, joinKey }) => {
  const countKeyName = 'count';

  try {
    let query = knex(joinTable);
    if (!isAdmin && hasStatusColumnTables.includes(tableName)) {
      query = query.where(`${tableName}.status`, 1);
    }
    const result = await query
        .select(`${joinKey} as id`, `${joinTable}.name`)
        .count(`${tableName}.id as ${countKeyName}`)
        .leftJoin(tableName, `${tableName}.${referenceKey}`, '=', `${joinTable}.id`)
        .groupBy(`${joinKey}`);
    // console.log(`Grouped by ${joinKey}s for ${tableName}:`, result);
    return result;
  } catch (error) {
    console.error(`Error fetching grouped by ${joinKey}s for ${tableName}:`, error);
    throw error;
  }
};

const fetchOwners = async (knex, { tableName, idField, relatedTableName, records, selectFields }) => {
  const ids = records.map(({ obj }) => obj[idField]);

  const response = await knex(tableName)
    .select(`${tableName}.${idField}`, ...selectFields)
    .join(relatedTableName, `${relatedTableName}.id`, `${tableName}.${idField}`)
    .whereIn(`${tableName}.${idField}`, [...new Set(ids)])
    .orderBy(`${tableName}.id`, 'asc');

  return ids.map(id => {
    const owner = response.find(r => r[idField] === id);
    return owner || {};
  });
};

const getCounts = async (knex, options = {}) => {
  const {
    tableName,
    foreignKeyName,
    relatedTableName,
    groupFieldName,
    countField = 'id',
    items, filter = {},
  } = options;
  const ids = items.map(({ obj }) => obj.id);
  const countKeyName = 'countRecords';
  try {
    let query = knex(tableName)
    .select(`${tableName}.id as ${groupFieldName}`)
    .count(`${countField} as ${countKeyName}`)
    .leftJoin(relatedTableName, `${tableName}.id`, `${relatedTableName}.${foreignKeyName}`)
    .whereIn(`${tableName}.id`, ids);

    if (filter && Object.keys(filter).length)
      query = query.where(filter);

    const counts = await query.groupBy(groupFieldName, `${relatedTableName}.${foreignKeyName}`);

    return items.map(({ obj }) => {
      const count = counts.find(({ [groupFieldName]: itemId }) => itemId === obj.id);
      return { [obj.id] : count ? count[countKeyName] : 0 };
    });
  } catch (error) {
    console.error(`Error counting ${relatedTableName}:`, error);
    throw new Error(`Unable to fetch ${relatedTableName} count`);
  }
};

const toggleStatus = async (knex, { tableName, idField, id, status, entityName }) => {
  const entity = await knex(tableName).where({ [idField]: id }).first();
  if (!entity) {
    throw new Error(`${entityName} not found`);
  }

  try {
    await knex(tableName).where({ [idField]: id }).update({ status: status ? 1 : 0 });
    return await knex(tableName).where({ [idField]: id }).first();
  } catch (error) {
    console.error(`toggle${entityName} error`, error);
    throw new Error(`Failed to toggle ${entityName} status`);
  }
};

module.exports = {
  fetchOwners,
  getCounts,
  countRowsForTables,
  fetchCounters,
  fetchGroupedByField,
  listTables,
  countRowsForTable,
  getFields,
  getWithPagination,
  toggleStatus,
};
