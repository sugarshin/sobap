"use strict"

Promise = require 'bluebird'
jsonp = require 'jsonp'
qs = require 'qs'

{ API_GOURMET } = require '../env'

module.exports = (query) ->
  new Promise (resolve, reject) ->
    jsonp API_GOURMET,
      param: qs.stringify(query, arrayFormat: 'repeat') + '&callback' # todo
    , (err, data) ->
      if err?　then reject err
      resolve data
