"use strict"

jsonp = require 'jsonp'
qs = require 'qs'
_ = require 'lodash'
Promise = require 'promise'
React = require 'react'
Eatery = require './eatery'
{ API_GOURMET, BASE_Q } = require '../env'

module.exports =
Eateries = React.createClass
  getGeo: ->
    new Promise (resolve, reject) ->
      navigator.geolocation.getCurrentPosition (pos, err) ->
        if err? then reject err
        resolve pos

  getData: (query) ->
    new Promise (resolve, reject) ->
      jsonp API_GOURMET,
        param: qs.stringify(query) + '&callback' # todo
      , (err, data) ->
        if err?
          console.error err
          reject err
        console.debug data
        resolve data

  getSearchWord: ->
    new Promise (resolve, reject) ->
      resolve searchAddress.value

  getInitialState: ->
    eateries: []


  updateEateriesByGeolocation: ->
    Promise.resolve()
      .then @getGeo
      .then (geoPos) =>
        query = _.assign _.cloneDeep(BASE_Q),
          lat: geoPos.coords.latitude
          lng: geoPos.coords.longitude
        @getData query
      .then (data) =>
        @setState eateries: data.results.shop

  componentDidMount: -> @updateEateriesByGeolocation()

  render: ->
    eateries = @state.eateries.map (eatery) ->
      eatery.c = eatery.catch
      <Eatery data={eatery} />

    <div className="eateries">
      {eateries}
    </div>
