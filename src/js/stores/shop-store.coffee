"use strict"

Promise = require 'bluebird'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'

{ API_GOURMET, BASE_QUERY } = require '../conf'
{ getShopData, getCurrentGeo } = require '../util/'

module.exports =
class ShopStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateShopsByGeo', @updateShopsByGeo
    dispatcher.on 'updateShopsByKeyword', @updateShopsByKeyword
    @state = shops: []

  getShops: -> @state.shops

  updateShopsByGeo: =>
    currentGeo = null # todo
    Promise.resolve()
      .then getCurrentGeo
      .then (geoPos) ->
        currentGeo =
          lat: geoPos.coords.latitude
          lng: geoPos.coords.longitude
        getShopData API_GOURMET, assign {}, BASE_QUERY, currentGeo
      .then (data) =>
        @emit 'change:shops', data, currentGeo

  updateShopsByKeyword: (keyword) =>
    Promise.resolve()
      .then ->
        getShopData API_GOURMET, assign {}, BASE_QUERY, keyword: keyword
      .then (data) =>
        @emit 'change:shops', data
