"use strict"

Promise = require 'bluebird'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
cloneDeep = require 'lodash.clonedeep'
includes = require 'lodash.includes'
remove = require 'lodash.remove'

{ BASE_QUERY } = require '../conf'
{ getShopData, store } = require '../util/'

module.exports =
class StarredShopStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateStarredShop', @updateStarredShop
    dispatcher.on 'fetchStarredID', @fetchStarredID
    @state = starredShops: []
    @_starredIDs = store 'starredShopsIDs'

  getStarredShops: -> @state.starredShops

  getStarredIDs: -> @_starredIDs

  updateStarredShop: (id) =>
    if id?
      @_toggleStarredID id
      @_saveStarredID()

    if @_starredIDs.length is 0
      return @emit 'change:starredShops', []

    Promise.resolve()
      .then =>
        getShopData assign cloneDeep(BASE_QUERY), id: @_starredIDs
      .then (data) =>
        @emit 'change:starredShops', data.results.shop

  _addStarredID: (id) ->　@_starredIDs.push id

  _removeStarredID: (id) ->　remove @_starredIDs, (el) -> el is id

  _toggleStarredID: (id) ->
    if includes(@_starredIDs, id)
      @_removeStarredID id
    else
      @_addStarredID id

  _saveStarredID: -> store 'starredShopsIDs', @_starredIDs
