# App

"use strict"

React = require 'react'
Promise = require 'bluebird'
jsonp = require 'jsonp'
qs = require 'qs'
_ = require 'lodash'

Header = require './header'
GoogleMap = require './google-map'
Shops = require './shops'
Footer = require './footer'
{ API_GOURMET, BASE_Q } = require '../env'

module.exports =
React.createClass
  getCurrentGeo: ->
    new Promise (resolve, reject) ->
      navigator.geolocation.getCurrentPosition (pos, err) ->
        if err? then reject err
        resolve pos

  getShopData: (query) ->
    new Promise (resolve, reject) ->
      jsonp API_GOURMET,
        param: qs.stringify(query) + '&callback' # todo
      , (err, data) ->
        if err?
          console.error err
          reject err
        # console.debug data
        resolve data

  getInitialState: -> shops: []

  componentDidMount: -> @updateShopsByGeolocation()

  updateShopsByGeolocation: ->
    currentGeo = null # todo
    Promise.resolve()
      .then @getCurrentGeo
      .then (geoPos) =>
        currentGeo =
          lat: geoPos.coords.latitude
          lng: geoPos.coords.longitude
        query = _.assign _.cloneDeep(BASE_Q), currentGeo
        @getShopData query
      .then (data) =>
        @setState shops: data.results.shop

        geos = _.map data.results.shop, (el, i) ->
          lat: el.lat, lng: el.lng
        @refs.googleMap.updateByCurrentGeo　currentGeo, geos

  updateShopsByKeyword: (keyword) ->
    Promise.resolve()
      .then =>
        query = _.assign _.cloneDeep(BASE_Q),
          keyword: keyword
        @getShopData query
      .then (data) =>
        @setState shops: data.results.shop

        geos = _.map data.results.shop, (el, i) ->
          lat: el.lat, lng: el.lng
        @refs.googleMap.updateByCurrentGeo　geos[0], geos

  onClickLocation: ->
    @updateShopsByGeolocation()

  onClickSearchKeyword: ->
    v = React.findDOMNode @refs.header
        .querySelector 'input[type=search]'
        .value
    @updateShopsByKeyword v

  render: ->
    <div className="app">
      <Header
        ref="header"
        onClickLocation={@onClickLocation}
        onClickSearchKeyword={@onClickSearchKeyword}
      />
      <GoogleMap ref="googleMap" />
      <div className="main">
        <Shops ref="shops" shops={@state.shops} />
      </div>
      <Footer />
    </div>
