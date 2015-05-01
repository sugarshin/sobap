# Actions

"use strict"

Promise = require 'bluebird'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
cloneDeep = require 'lodash.clonedeep'

{ BASE_QUERY } = require '../env'
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
        query = assign cloneDeep(BASE_QUERY), currentGeo
        getShopData query
      .then (data) =>
        @emit 'change:shops', data, currentGeo

  updateShopsByKeyword: (keyword) =>
    Promise.resolve()
      .then ->
        query = assign cloneDeep(BASE_QUERY),
          keyword: keyword
        getShopData query
      .then (data) =>
        @emit 'change:shops', data
