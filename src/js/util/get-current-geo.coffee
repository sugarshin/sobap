"use strict"

Promise = require 'bluebird'

module.exports = ->
  new Promise (resolve, reject) ->
    navigator.geolocation.getCurrentPosition (pos, err) ->
      if err? then reject err
      resolve pos
