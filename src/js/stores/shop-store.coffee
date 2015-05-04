"use strict"

EventEmitter = require 'eventemitter3'

module.exports =
class ShopStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateShops', @updateShops
    @state = shops: []

  getShops: -> @state.shops

  # currentGeo Provisional
  updateShops: (data, currentGeo) =>
    @state.shops = data.results.shop
    @emit 'change:shops', currentGeo
