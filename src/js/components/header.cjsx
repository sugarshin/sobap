"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/header.jade'

module.exports =
Header = React.createClass

  _onClickLocation: -> this.props.onClickLocation()
  _onClickSearchKeyword: -> this.props.onClickSearchKeyword()

  componentDidMount: ->

  render: ->
    template
      onClickLocation: this._onClickLocation
      onClickSearchKeyword: this._onClickSearchKeyword
