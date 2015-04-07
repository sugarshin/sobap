# Shops

"use strict"

React = require 'react'
Promise = require 'promise'
jsonp = require 'jsonp'
qs = require 'qs'
_ = require 'lodash'
Shop = require './shop'
{ API_GOURMET, BASE_Q } = require '../env'

module.exports =
React.createClass
  _getGeo: ->
    new Promise (resolve, reject) ->
      navigator.geolocation.getCurrentPosition (pos, err) ->
        if err? then reject err
        resolve pos

  _getData: (query) ->
    new Promise (resolve, reject) ->
      jsonp API_GOURMET,
        param: qs.stringify(query) + '&callback' # todo
      , (err, data) ->
        if err?
          console.error err
          reject err
        # console.debug data
        resolve data

  _getSearchWord: ->
    new Promise (resolve, reject) ->
      resolve searchAddress.value

  componentDidMount: -> @updateShopsByGeolocation()

  getInitialState: -> shops: []

  updateShopsByGeolocation: ->
    Promise.resolve()
      .then @_getGeo
      .then (geoPos) =>
        query = _.assign _.cloneDeep(BASE_Q),
          lat: geoPos.coords.latitude
          lng: geoPos.coords.longitude
        @_getData query
      .then (data) =>
        @setState shops: data.results.shop

  updateShopsByKeyword: (word) ->
    Promise.resolve()
      .then =>
        query = _.assign _.cloneDeep(BASE_Q),
          keyword: word
        @_getData query
      .then (data) =>
        @setState shops: data.results.shop

  render: ->
    <div className="shops">
      {@state.shops.map (shop) -> <Shop key={shop.id} data={shop} />}
    </div>
