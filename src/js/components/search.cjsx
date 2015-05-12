"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

SearchBar = require './partials/search-bar'
GoogleMap = require './partials/google-map'
Shops = require './partials/shops'

actions = require '../actions/actions'
shopStore = require '../stores/shop-store'
# todo
starredShopStore = require '../stores/starred-shop-store'

module.exports =
class Search extends React.Component

  # @propTypes:

  # @defaultProps =

  constructor: (props) ->
    super props

    @state =
      shops: shopStore.getShops()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  _handleClickLocation: =>
    actions.searchShopByLocation()

  _handleClickSearchKeyword: (value) =>
    actions.searchShopByKeyword value

  _handleClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id

  _changeShops: => @setState shops: shopStore.getShops()

  _changeStarredShops: =>
    @setState starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  componentDidMount: ->
    shopStore.addChangeListener @_changeShops
    starredShopStore.addChangeListener @_changeStarredShops

    actions.fetchStarredShop()
    actions.searchShopByLocation()

  componentWillUnmount: ->
    shopStore.removeChangeListener @_changeShops
    starredShopStore.removeChangeListener @_changeStarredShops

  render: ->
    <div>
      <SearchBar
        onClickLocation={@_handleClickLocation}
        onClickSearchKeyword={@_handleClickSearchKeyword}
      />
      <GoogleMap
        markers={@state.shops.map (shop) -> lat: shop.lat, lng: shop.lng, id: shop.id}
      />
      <div className="main">
        <Shops
          classNames={'shops'}
          shops={@state.shops}
          onClickStar={@_handleClickStar}
          starredIDs={@state.starredIDs}
        />
      </div>
      <RouteHandler />
    </div>
