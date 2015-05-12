# TODO

"use strict"

React = require 'react'

module.exports =
class GoogleMap extends React.Component

  @propTypes:
    markers: React.PropTypes.array

  # @defaultProps:

  constructor: (props) ->
    super props

    @_map = null
    @_markers = []
    # @_currentMarker = null
    # @_infoWindow = null

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
      google.maps.event.addListener m, 'click', ->
        location.hash = "/shop/#{m.url}"

  removeAllMarker: ->
    for marker in @_markers
      marker.setMap null

  componentWillReceiveProps: (nextProps) ->
    # console.log '@props', @props.markers
    # console.log 'nextProps', nextProps.markers
    @updateByCurrentGeo nextProps.markers if nextProps.markers.length > 0

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

    new google.maps.Map React.findDOMNode(@refs.mapCanvas), mapOpts

  createMarker: (coords, id) ->
    new google.maps.Marker
      position: new google.maps.LatLng coords.latitude, coords.longitude
      map: @_map
      url: id

  # createInfoWindow: ->
  #   contentString = '<div class="InfoWindow"></div>'
  #   @_infoWindow = new google.maps.InfoWindow
  #     map: @_map
  #     anchor: @marker
  #     content: contentString

  # onZoomChange: ->
  #
  # onDragEnd: ->

  render: ->
    <div className="google-map">
      <div ref="mapCanvas" className="google-map-canvas"></div>
    </div>
