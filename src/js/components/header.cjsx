"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/header.jade'

module.exports =
Header = React.createClass
  # propTypes:
  #   onClickLocation: React.PropTypes.func.isRequired

  _onChangeComplet: ->
    this.props.onClickLocation()

  componentDidMount: ->

  render: -> template onClick: this._onChangeComplet
