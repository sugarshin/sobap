"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/header.jade"

module.exports =
class Header extends React.Component

  constructor: (props) ->
    super props

  _onClickLocation: => @props.onClickLocation()
  _onClickSearchKeyword: => @props.onClickSearchKeyword()

  render: ->
    template
      onClickLocation: @_onClickLocation
      onClickSearchKeyword: @_onClickSearchKeyword

# Header.propTypes =
# Header.defaultProps =
