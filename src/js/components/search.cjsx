"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

SearchBar = require './partials/search-bar'
GoogleMap = require './partials/google-map'
Shops = require './partials/shops'

shopStore = require '../stores/shop-store'
starredShopStore = require '../stores/starred-shop-store'# todo

module.exports =
class Search extends React.Component

  # @propTypes:

  # @defaultProps =

  constructor: (props) ->
    super props

    @state =
      shops: shopStore.getShops()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  componentDidMount: ->
    shopStore.addChangeListener @_changeShops
    starredShopStore.addChangeListener @_changeStarredShops

  componentWillUnmount: ->
    shopStore.removeChangeListener @_changeShops
    starredShopStore.removeChangeListener @_changeStarredShops

  _changeShops: => @setState shops: shopStore.getShops()

  _changeStarredShops: =>
    @setState starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  render: ->
    <div>
      <SearchBar />
      <GoogleMap
        markers={@state.shops.map (shop) -> lat: shop.lat, lng: shop.lng, id: shop.id}
      />
      <div className="main">
        <Shops
          key={'search-shops'}
          classNames={'shops'}
          shops={@state.shops}
          starredIDs={@state.starredIDs}
        />
      </div>
      <RouteHandler />
    </div>
