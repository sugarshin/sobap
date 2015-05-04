"use strict"

assign = require 'object-assign'
includes = require 'lodash.includes'
remove = require 'lodash.remove'

{ API_GOURMET, BASE_QUERY } = require '../conf'
{ getShopData, getCurrentGeo, store } = require '../util/'

module.exports =
class Actions

  constructor: (@dispatcher) ->
    # Pseudo API
    @_starredIDs = store 'starredShopsIDs'

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
      getShopData API_GOURMET, assign {}, BASE_QUERY, currentGeo
    .then (data) =>
      @dispatcher.emit 'updateShops', data, currentGeo　# Provisional

  updateShopsByKeyword: (keyword) ->
    Promise.resolve()
    .then ->
      getShopData API_GOURMET, assign {}, BASE_QUERY, keyword: keyword
    .then (data) =>
      @dispatcher.emit 'updateShops', data

  updateStarredShops: (id) ->
    # todo
    if id?
      @_toggleStarredID id
      @_saveStarredID()

    # todo
    if @_starredIDs.length is 0
      return @dispatcher.emit 'updateStarredShops', results: shop: []

    Promise.resolve()
    .then =>
      getShopData API_GOURMET, assign {}, BASE_QUERY, id: @_starredIDs
    .then (data) =>
      @dispatcher.emit 'updateStarredShops', data

  _addStarredID: (id) ->　@_starredIDs.push id

  _removeStarredID: (id) ->　remove @_starredIDs, (el) -> el is id

  _toggleStarredID: (id) ->
    if includes(@_starredIDs, id)
      @_removeStarredID id
    else
      @_addStarredID id

  _saveStarredID: -> store 'starredShopsIDs', @_starredIDs
