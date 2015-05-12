"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

Shops = require './partials/shops'

actions = require '../actions/actions'
starredShopStore = require '../stores/starred-shop-store'

module.exports =
class Star extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

    @state =
      shops: starredShopStore.getShops()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  _changeStarredShops: =>
    @setState
      shops: starredShopStore.getShops()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  _handleClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id

  componentDidMount: ->
    starredShopStore.addChangeListener @_changeStarredShops

    actions.fetchStarredShop()

  componentWillUnmount: ->
    starredShopStore.removeChangeListener @_changeStarredShops

  render: ->
    <div style={padding: '40px 0 0'}>
      <div className="main">
        <Shops
          classNames={'shops starred-shops'}
          shops={@state.shops}
          onClickStar={@_handleClickStar}
          starredIDs={@state.starredIDs}
        />
      </div>
      <RouteHandler />
    </div>
