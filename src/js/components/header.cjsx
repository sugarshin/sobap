"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/header.jade'

module.exports =
class Header
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->
    console.log @

  render: -> template()
