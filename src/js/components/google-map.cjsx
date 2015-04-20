# GoogleMap

"use strict"

React = require 'react'
# Promise = require 'bluebird'

module.exports =
React.createClass

  # getCurrentGeo: ->
  #   new Promise (resolve, reject) ->
  #     navigator.geolocation.getCurrentPosition (pos, err) ->
  #       if err? then reject err
  #       resolve pos

  # getInitialState: ->

  # getDefaultProps: ->

  map: null
  currentMarker: null
  markers: []
  infoWindow: null

  render: ->
    <div className="google-map">
      <div ref="mapCanvas" style={'height': '100%'}></div>
    </div>

  updateByCurrentGeo: (center, geos) ->
    @map.panTo new google.maps.LatLng center.lat, center.lng
    @removeAllMarker()
    geos.forEach (el, i) =>
      @markers.push @createMarker latitude: el.lat, longitude: el.lng

  removeAllMarker: ->
    for marker, i in @markers
      marker.setMap null

  componentDidMount: ->
    @map = @createMap latitude: 35.6895, longitude: 139.69164
    # @getCurrentGeo().then (geo) =>
    #   @map = @createMap latitude: 35.6895, longitude: 139.69164
    #   # @marker = @createMarker()
    #   # @infoWindow = @createInfoWindow()
    #
    google.maps.event.addListener @map, 'zoom_changed', => @onZoomChange()
    google.maps.event.addListener @map, 'dragend', => @onDragEnd()

  createMap: (coords) ->
    mapOpts =
      minZoom: 5
      zoom: 13
      center: new google.maps.LatLng coords.latitude, coords.longitude

    new google.maps.Map @refs.mapCanvas.getDOMNode(), mapOpts

  createMarker: (coords) ->
    new google.maps.Marker
      position: new google.maps.LatLng coords.latitude, coords.longitude
      map: @map

  createInfoWindow: ->
    contentString = '<div class="InfoWindow">Im a Window that contains Info Yay</div>'
    infoWindow = new google.maps.InfoWindow
      map: @map
      anchor: @marker
      content: contentString

  onZoomChange: ->

  onDragEnd: ->
