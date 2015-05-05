"use strict"

EventEmitter = require 'eventemitter3'

Actions = require './actions/actions'
Store = require './stores/store'

dispatcher = new EventEmitter

module.exports =
  actions: new Actions dispatcher
  store: new Store dispatcher
