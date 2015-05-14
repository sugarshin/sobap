"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'
includes = require 'lodash.includes'

ShopDetailBody = require './partials/shop-detail-body'

actions = require '../actions/actions'
shopDetailStore = require '../stores/shop-detail-store'
starredShopStore = require '../stores/starred-shop-store'# todo

module.exports =
class ShopDetail extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

    @state =
      shop: shopDetailStore.getShop()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  componentDidMount: ->
    shopDetailStore.addChangeListener @_changeShop
    starredShopStore.addChangeListener @_changeStarredShops

    actions.updateShopDetail @props.params.id

  componentWillUnmount: ->
    shopDetailStore.removeChangeListener @_changeShop
    starredShopStore.removeChangeListener @_changeStarredShops

  _changeShop: => @setState shop: shopDetailStore.getShop()

  _changeStarredShops: =>
    @setState starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  render: ->
    <ShopDetailBody
      data={@state.shop}
      isStarred={includes @state.starredIDs, @props.params.id}
    />
