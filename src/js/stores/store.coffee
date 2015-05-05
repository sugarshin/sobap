"use strict"

EventEmitter = require 'eventemitter3'

module.exports =
class Store extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateShops', @updateShops
    dispatcher.on 'updateMap', @updateMap
    dispatcher.on 'updateStarredShops', @updateStarredShops

    @state =
      shops: []
      starredShops: []

  getShops: -> @state.shops
  getStarredShops: -> @state.starredShops
  getStarredIDs: ->
    @state.starredShops.map (shop) -> shop.id

  # currentGeo Provisional
  updateShops: (data, currentGeo) =>
    @state.shops = data.results.shop
    @emit 'change:shops', currentGeo

  updateStarredShops: (data) =>
    @state.starredShops = data.results.shop
    @emit 'change:starredShops'#, data

  # currentGeo Provisional
  updateMap: (geos, currentGeo) =>
    @emit 'change:map', geos, currentGeo
