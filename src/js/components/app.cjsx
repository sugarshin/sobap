"use strict"

React = require 'react'
Promise = require 'bluebird'
jsonp = require 'jsonp'
qs = require 'qs'
assign = require 'object-assign'
cloneDeep = require 'lodash.clonedeep'
includes = require 'lodash.includes'
remove = require 'lodash.remove'

Header = require './header'
GoogleMap = require './google-map'
Shops = require './shops'
Footer = require './footer'
{ API_GOURMET, BASE_Q } = require '../env'
{ store } = require '../util'

module.exports =
class App extends React.Component

  constructor: (props) ->
    super props

    @state =
      shops: []
      starredShops: []

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

  _starredIDs: []

  componentWillMount: ->
    @fetchStarredID()

  componentDidMount: ->
    @updateStarredShops()
    @updateShopsByGeolocation()

  updateStarredShops: ->
    if @_starredIDs.length is 0 then return @setState starredShops: []
    Promise.resolve()
      .then =>
        @getShopData assign cloneDeep(BASE_Q), id: @_starredIDs
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
        query = assign cloneDeep(BASE_Q), currentGeo
        @getShopData query
      .then (data) =>
        @setState shops: data.results.shop

        geos = data.results.shop.map (el) ->
          lat: el.lat, lng: el.lng, id: el.id
        @refs.googleMap.updateByCurrentGeo　currentGeo, geos

  updateShopsByKeyword: (keyword) ->
    Promise.resolve()
      .then =>
        query = assign cloneDeep(BASE_Q),
          keyword: keyword
        @getShopData query
      .then (data) =>
        @setState shops: data.results.shop

        geos = data.results.shop.map (el) ->
          lat: el.lat, lng: el.lng, id: el.id
        @refs.googleMap.updateByCurrentGeo　geos[0], geos

  onClickLocation: =>　@updateShopsByGeolocation()

  onClickSearchKeyword: =>
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
    remove @_starredIDs, (el) -> el is id
    @updateStarredShops()
    @saveStarredID()

  toggleStarredID: (id) ->
    if includes(@_starredIDs, id)
      @removeStarredID id
    else
      @addStarredID id

  onClickStar: (ev, reactID) => @toggleStarredID ev.currentTarget.id
  onClickStarredStar: (ev, reactID) => @removeStarredID ev.currentTarget.id

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

# App.propTypes =
# App.defaultProps =
