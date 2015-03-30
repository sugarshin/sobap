"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/footer.jade'

module.exports =
Footer = React.createClass
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->

  render: -> template()
