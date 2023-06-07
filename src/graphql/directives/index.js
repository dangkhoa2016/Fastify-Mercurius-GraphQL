'use strict'

const directiveResolvers = {
  isSuccess: (next, source, args, context) => {
    return next(source, args, context)
  },

  isErro: () => {
    return new Error('Isso é um erro gerado na diretiva')
  }
}

module.exports = { directiveResolvers }
