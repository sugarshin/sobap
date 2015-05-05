"use strict"

React = require 'react'

{ actions, store } = require '../flux' # todo

# todo
module.exports =
class GoogleMap extends React.Component

  constructor: (props) ->
    super props

    store.on 'change:map', @_onUpdateMap

    @_map = null
    @_currentMarker = null
    @_markers = []
    @_infoWindow = null

  _onUpdateMap: (geos, currentGeo) =>
    @updateByCurrentGeo geos, currentGeo

  updateByCurrentGeo: (geos, center) ->
    # todo
    if center?
      @_map.panTo new google.maps.LatLng center.lat, center.lng
    else
      bounds = new google.maps.LatLngBounds
      geos.forEach (el) ->
        bounds.extend new google.maps.LatLng el.lat, el.lng
      @_map.fitBounds bounds

    @removeAllMarker()

    # todo
    geos.forEach (el) =>
      m = @createMarker
        latitude: el.lat
        longitude: el.lng
      , el.id
      @_markers.push m
      # google.maps.event.addListener m, 'click', ->
      #   location.hash = m.url

  removeAllMarker: ->
    for marker in @_markers
      marker.setMap null

  componentDidMount: ->
    # todo
    @_map = @createMap latitude: 35.6895, longitude: 139.69164
    # google.maps.event.addListener @_map, 'zoom_changed', => @onZoomChange()
    # google.maps.event.addListener @_map, 'dragend', => @onDragEnd()

  createMap: (coords) ->
    mapOpts =
      minZoom: 5
      zoom: 13
      center: new google.maps.LatLng coords.latitude, coords.longitude

    new google.maps.Map @refs.mapCanvas.getDOMNode(), mapOpts

  createMarker: (coords, id) ->
    new google.maps.Marker
      position: new google.maps.LatLng coords.latitude, coords.longitude
      map: @_map
      url: id

  createInfoWindow: ->
    contentString = '<div class="InfoWindow"></div>'
    @_infoWindow = new google.maps.InfoWindow
      map: @_map
      anchor: @marker
      content: contentString

  # onZoomChange: ->
  #
  # onDragEnd: ->

  render: ->
    <div className="google-map">
      <div ref="mapCanvas" style={'height': '100%'}></div>
    </div>

# GoogleMap.propTypes =
# GoogleMap.defaultProps =
