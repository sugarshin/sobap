"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/eatery.jade'

module.exports =
class Eatery
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->
    console.log @

  render: -> template this.props.data
