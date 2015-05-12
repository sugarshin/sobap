"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../../templates/shop.jade"

module.exports =
class Shop extends React.Component

  @propTypes:
    data: React.PropTypes.object
    onClickStar: React.PropTypes.func
    isStarred: React.PropTypes.bool

  # @defaultProps:

  constructor: (props) ->
    super props

  render: -> template @props
