"use strict"

React = require 'react'
{ run, HashLocation } = require 'react-router'

routes = require './routes'

run routes, HashLocation, (Root) ->
  React.render <Root />, document.getElementById 'container'
