"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'
{ GoogleMaps, Marker } = require 'react-google-maps'

SearchBar = require './partials/search-bar'
Shops = require './partials/shops'

shopStore = require '../stores/shop-store'
starredShopStore = require '../stores/starred-shop-store'# todo

module.exports =
class Search extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

    @state =
      shops: shopStore.getShops()
      starredIDs: starredShopStore.getShops().map (shop) -> shop.id
      markers: shopStore.getShops().map (shop) ->
        lat: shop.lat, lng: shop.lng, id: shop.id

  componentDidMount: ->
    shopStore.addChangeListener @_changeShops
    starredShopStore.addChangeListener @_changeStarredShops

  componentWillUnmount: ->
    shopStore.removeChangeListener @_changeShops
    starredShopStore.removeChangeListener @_changeStarredShops

  componentDidUpdate: ->
    bounds = new google.maps.LatLngBounds
    @state.markers.forEach (marker) ->
      bounds.extend new google.maps.LatLng marker.lat, marker.lng
    @refs.googlemaps.fitBounds bounds

  _changeShops: =>
    shops = shopStore.getShops()
    @setState
      shops: shops
      markers: shops.map (shop) -> lat: shop.lat, lng: shop.lng, id: shop.id

  _changeStarredShops: =>
    @setState starredIDs: starredShopStore.getShops().map (shop) -> shop.id

  _handleMarkerClick: (id) => location.hash = "/shop/#{id}"

  render: ->
    <div>
      <SearchBar />
      <div className={'google-map-container'}>
        <GoogleMaps
          containerProps={style: height: '100%'}
          ref="googlemaps"
          googleMapsApi={google.maps}
        >
          {@state.markers.map (marker) =>
            console.log +marker.lat
            <Marker
              key={"marker_#{marker.id}"}
              position={lat: +marker.lat, lng: +marker.lng}
              onClick={=> @_handleMarkerClick marker.id}
            />}
        </GoogleMaps>
      </div>
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
