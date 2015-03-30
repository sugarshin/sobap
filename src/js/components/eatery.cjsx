"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/eatery.jade'

module.exports =
Eatery = React.createClass
  propTypes:
    data: React.PropTypes.object

  componentDidMount: ->

  render: -> template this.props.data
