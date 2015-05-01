"use strict"

React = require 'react'

# todo
module.exports =
class GoogleMap extends React.Component

  constructor: (props) ->
    super props

  map: null
  currentMarker: null
  markers: []
  infoWindow: null

  updateByCurrentGeo: (center, geos) ->
    @map.panTo new google.maps.LatLng center.lat, center.lng
    @removeAllMarker()

    # todo
    geos.forEach (el, i) =>
      m = @createMarker {latitude: el.lat, longitude: el.lng}, el.id
      @markers.push m
      google.maps.event.addListener m, 'click', ->
        location.hash = m.url

  removeAllMarker: ->
    for marker, i in @markers
      marker.setMap null

  componentDidMount: ->
    # todo
    @map = @createMap latitude: 35.6895, longitude: 139.69164
    # google.maps.event.addListener @map, 'zoom_changed', => @onZoomChange()
    # google.maps.event.addListener @map, 'dragend', => @onDragEnd()

  createMap: (coords) ->
    mapOpts =
      minZoom: 5
      zoom: 13
      center: new google.maps.LatLng coords.latitude, coords.longitude

    new google.maps.Map @refs.mapCanvas.getDOMNode(), mapOpts

  createMarker: (coords, id) ->
    new google.maps.Marker
      position: new google.maps.LatLng coords.latitude, coords.longitude
      map: @map
      url: id

  createInfoWindow: ->
    contentString = '<div class="InfoWindow"></div>'
    infoWindow = new google.maps.InfoWindow
      map: @map
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
