"use strict"

React = require 'react'
jade = require 'react-jade'

template = jade.compileFile "#{__dirname}/../templates/shop-detail-body.jade"

module.exports =
class ShopDetailBody extends React.Component

  constructor: (props) ->
    super props

  render: -> template @props

  @propTypes:
    data: React.PropTypes.object
    onClickStar: React.PropTypes.func
    isStarred: React.PropTypes.bool
  # @defaultProps =
