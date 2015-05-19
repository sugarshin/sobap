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

    shops = shopStore.getShops()
    @state =
      isResultsByGeolocation: shopStore.getResultsByGeolocation()
      shops: shops
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id
      markers: shops.map (shop) -> lat: +shop.lat, lng: +shop.lng, id: shop.id

  componentDidMount: ->
    shopStore.addChangeListener @_changeShops
    starredShopStore.addChangeListener @_changeStarredShops

  componentWillUnmount: ->
    shopStore.removeChangeListener @_changeShops
    starredShopStore.removeChangeListener @_changeStarredShops

  _changeShops: =>
    shops = shopStore.getShops()
    @setState
      isResultsByGeolocation: shopStore.getResultsByGeolocation()
      shops: shops
      markers: shops.map (shop) -> lat: +shop.lat, lng: +shop.lng, id: shop.id

  _changeStarredShops: =>
    @setState starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  render: ->
    <div>
      <SearchBar
        isResultsByGeolocation={@state.isResultsByGeolocation}
      />
      <GoogleMap
        markers={@state.markers}
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
