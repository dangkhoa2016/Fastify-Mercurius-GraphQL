const { mapSchema, getDirective, MapperKind } = require("@graphql-tools/utils")

const redactionSchemaTransformer = (schema) =>
  mapSchema(schema, {
    [MapperKind.OBJECT_FIELD]: (fieldConfig) => {
      const redactDirective = getDirective(schema, fieldConfig, "redact")

      if (redactDirective) {
        const [result] = redactDirective

        fieldConfig.resolve = async (obj, _args, _ctx, info) => {

          const value = obj[info.fieldName]

          switch (result.find) {
            case 'lower':
              return value.toLowerCase()
            case 'upper':
              return value.toUpperCase()
            default:
              return value
          }
        }
      }
    },
  })

module.exports = { redactionSchemaTransformer }