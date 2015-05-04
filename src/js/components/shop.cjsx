"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/shop.jade"

module.exports =
class Shop extends React.Component

  constructor: (props) ->
    super props

  render: -> template @props

Shop.propTypes =
  data: React.PropTypes.object
  onClickStar: React.PropTypes.func
  isStarred: React.PropTypes.bool
# Shop.defaultProps =
