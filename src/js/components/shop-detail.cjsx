"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'
includes = require 'lodash.includes'

ShopDetailBody = require './shop-detail-body'

module.exports =
class ShopDetail extends React.Component

  constructor: (props) ->
    super props

  _onClickStar: (e) =>
    @props.onClickStar e.currentTarget.id
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  componentWillMount: ->
    @props.onUpdateShopDetail @props.params.id

  render: ->
    <ShopDetailBody
      data={@props.shopDetail}
      onClickStar={@_onClickStar}
      isStarred={includes @props.starredIDs, @props.params.id}
    />

  @propTypes:
    shopDetail: React.PropTypes.object
    onClickStar: React.PropTypes.func
    starredIDs: React.PropTypes.array
    updateShopDetail: React.PropTypes.func
  # @defaultProps =
