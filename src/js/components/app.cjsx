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
{ store } = require '../util'

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
        param: qs.stringify(query, arrayFormat: 'repeat') + '&callback' # todo
      , (err, data) ->
        if err?　then reject err
        resolve data

  getInitialState: ->
    shops: []
    starredShops: []

  _starredIDs: []

  componentWillMount: -> @fetchStarredID()

  componentDidMount: ->
    @updateStarredShops()
    @updateShopsByGeolocation()

  updateStarredShops: ->
    if @_starredIDs.length is 0 then return @setState starredShops: []
    Promise.resolve()
      .then =>
        @getShopData _.assign _.cloneDeep(BASE_Q), id: @_starredIDs
      .then (data) =>
        @setState starredShops: data.results.shop

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

  onClickLocation: ->　@updateShopsByGeolocation()

  onClickSearchKeyword: ->
    # todo
    v = React.findDOMNode @refs.header
        .querySelector 'input[type=search]'
        .value
    @updateShopsByKeyword v

  fetchStarredID: -> @_starredIDs = store 'starredShopsIDs'

  saveStarredID: -> store 'starredShopsIDs', @_starredIDs

  addStarredID: (id) ->
    @_starredIDs.push id
    @updateStarredShops()
    @saveStarredID()

  removeStarredID: (id) ->
    _.remove @_starredIDs, (el) -> el is id
    @updateStarredShops()
    @saveStarredID()

  toggleStarredID: (id) ->
    if _.includes(@_starredIDs, id)
      @removeStarredID id
    else
      @addStarredID id

  onClickStar: (ev, reactID) -> @toggleStarredID ev.currentTarget.id
  onClickStarredStar: (ev, reactID) -> @removeStarredID ev.currentTarget.id

  render: ->
    <div className="app">
      <Header
        ref="header"
        onClickLocation={@onClickLocation}
        onClickSearchKeyword={@onClickSearchKeyword}
      />
      <GoogleMap ref="googleMap" />
      <div className="main">
        <Shops
          ref="starredShops"
          classNames={'shops starred-shops'}
          shops={@state.starredShops}
          onClickStar={@onClickStarredStar}
          starredIDs={@_starredIDs}
        />
        <Shops
          ref="shops"
          classNames={'shops'}
          shops={@state.shops}
          onClickStar={@onClickStar}
          starredIDs={@_starredIDs}
        />
      </div>
      <Footer />
    </div>
