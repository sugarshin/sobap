"use strict"

Promise = require 'bluebird'
EventEmitter = require 'eventemitter3'

module.exports =
class ShopStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateShops', @updateShops#ByGeo
    @state = shops: []

  getShops: -> @state.shops

  updateShops: (data) =>
    @state.shops = data.results.shop
    @emit 'change:shops'#, data
