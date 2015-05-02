"use strict"

EventEmitter = require 'eventemitter3'

module.exports =
class StarredShopStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateStarredShops', @updateStarredShops
    @state = starredShops: []

  getStarredShops: -> @state.starredShops

  getStarredIDs: ->
    @state.starredShops.map (shop) -> shop.id

  updateStarredShops: (data) =>
    @state.starredShops = data.results.shop
    @emit 'change:starredShops'#, data
