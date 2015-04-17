# Shop

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/shop.jade"

module.exports =
React.createClass
  propTypes:
    data: React.PropTypes.object

  componentDidMount: ->

  # _onClickStar: ->

  render: ->
    template
      data: @props.data
      onClickStar: @_onClickStar
