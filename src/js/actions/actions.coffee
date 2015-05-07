"use strict"

assign = require 'object-assign'
includes = require 'lodash.includes'
remove = require 'lodash.remove'

{ API_GOURMET, BASE_QUERY } = require '../conf'
{ getShopData, getCurrentGeo, localStorage } = require '../util/'

module.exports =
class Actions

  constructor: (@dispatcher) ->
    # Pseudo API
    @_starredIDs = localStorage 'starredShopsIDs'

  fetchStarredShops: ->
    @_starredIDs.forEach (id) => @addStarredShop id

  addStarredShop: (id) ->
    Promise.resolve()
    .then =>
      getShopData API_GOURMET, assign {}, BASE_QUERY, id: id
    .then (data) =>
      @dispatcher.emit 'updateStarredShops', data

  removeStarredShop: (id) ->
    @dispatcher.emit 'updateStarredShops', id

  updateStarredIDs: (id) ->
    if includes(@_starredIDs, id)
      @_removeStarredID id
      @removeStarredShop id
    else
      @_addStarredID id
      @addStarredShop id
    @saveStarredIDs()

  saveStarredIDs: -> localStorage 'starredShopsIDs', @_starredIDs

  updateShopDetail: (id) ->
    Promise.resolve()
    .then ->
      getShopData API_GOURMET, assign {}, BASE_QUERY, id: id
    .then (data) =>
      @dispatcher.emit 'updateShopDetail', data

  updateMap: (geos, currentGeo) ->
    @dispatcher.emit 'updateMap', geos, currentGeo

  updateShopsByGeo: ->
    currentGeo = null # Provisional

    Promise.resolve()
    .then getCurrentGeo
    .then (geoPos) ->
      currentGeo =
        lat: geoPos.coords.latitude
        lng: geoPos.coords.longitude
      getShopData API_GOURMET, assign {}, BASE_QUERY, currentGeo, type: 'lite'
    .then (data) =>
      @dispatcher.emit 'updateShops', data, currentGeo# Provisional

  updateShopsByKeyword: (keyword) ->
    Promise.resolve()
    .then ->
      getShopData API_GOURMET, assign {}, BASE_QUERY, keyword: keyword, type: 'lite'
    .then (data) =>
      @dispatcher.emit 'updateShops', data

  _addStarredID: (id) ->　@_starredIDs.push id

  _removeStarredID: (id) ->　remove @_starredIDs, (el) -> el is id
