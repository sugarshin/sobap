"use strict"

Promise = require 'bluebird'
jsonp = require 'jsonp'
qs = require 'qs'

module.exports = (url, query) ->
  new Promise (resolve, reject) ->
    jsonp url,
      param: qs.stringify(query, arrayFormat: 'repeat') + '&callback' # todo
    , (err, data) ->
      if err?　then reject err
      resolve data
