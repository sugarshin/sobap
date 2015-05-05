"use strict"

React = require 'react'
jade = require 'react-jade'

template = jade.compileFile "#{__dirname}/../templates/shop-detail-body.jade"

module.exports =
class ShopDetailBody extends React.Component

  constructor: (props) ->
    super props

  # componentWillMount: ->
  #   @props.onUpdateShopDetail @props.params.id

  render: -> template @props

  @propTypes:
    onClickStar: React.PropTypes.func
    isStarred: React.PropTypes.bool
  # @defaultProps =
