# Shop

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/shop.jade"

module.exports =
React.createClass
  propTypes:
    data: React.PropTypes.object
    onClickStar: React.PropTypes.func
    isStarred: React.PropTypes.bool

  componentDidMount: ->

  render: ->
    template
      data: @props.data
      onClickStar: @props.onClickStar
      starred: @props.isStarred
