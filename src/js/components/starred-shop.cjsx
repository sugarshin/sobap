# StarredShop

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/shop.jade"

module.exports =
React.createClass
  propTypes:
    data: React.PropTypes.object

  componentDidMount: ->

  render: ->
    # console.log @props.data
    template
      data: @props.data
      onClickStar: @props.onClickStar
      starred: true
