"use strict"

EventEmitter = require 'eventemitter3'

module.exports =
class MapStore extends EventEmitter

  constructor: (dispatcher) ->
    super
    dispatcher.on 'updateMap', @updateMap
    # @state =
    #   geos: {}
    #   currentGeo: {}

  # get: -> @state

  # currentGeo Provisional
  updateMap: (geos, currentGeo) =>
    # @state =
    #   geos: geos
    #   currentGeo: currentGeo
    @emit 'change:map', geos, currentGeo
