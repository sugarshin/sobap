# Actions

"use strict"

module.exports =
class Actions

  constructor: (@dispatcher) ->

  updateShopsByGeo: -> @dispatcher.emit 'updateShopsByGeo'

  updateShopsByKeyword: (keyword) -> @dispatcher.emit 'updateShopsByKeyword', keyword

  updateStarredShop: (id) -> @dispatcher.emit 'updateStarredShop', id
