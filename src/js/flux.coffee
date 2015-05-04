"use strict"

EventEmitter = require 'eventemitter3'

Actions = require './actions/actions'
ShopStore = require './stores/shop-store'
StarredShopStore = require './stores/starred-shop-store'
MapStore = require './stores/map-store'

dispatcher = new EventEmitter

module.exports =
  actions: new Actions dispatcher
  shopStore: new ShopStore dispatcher
  starredShopStore: new StarredShopStore dispatcher
  mapStore: new MapStore dispatcher
