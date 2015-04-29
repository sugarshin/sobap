# Header

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/header.jade"

module.exports =
React.createClass

  _onClickLocation: -> @props.onClickLocation()
  _onClickSearchKeyword: -> @props.onClickSearchKeyword()

  render: ->
    template
      onClickLocation: @_onClickLocation
      onClickSearchKeyword: @_onClickSearchKeyword
