# TODO

"use strict"

React = require 'react'

Component = React.Component
PropTypes = React.PropTypes
findDOMNode = React.findDOMNode

module.exports =
class GoogleMap extends Component

  @propTypes:
    initialCenterPos: PropTypes.shape
      lat: PropTypes.number
      lng: PropTypes.number
    markers: PropTypes.array

  @defaultProps:
    initialCenterPos:
      lat: 35.6895
      lng: 139.69164

  constructor: (props) ->
    super props
    @_map = null
    @_markers = []
    @_centerPos = @props.initialCenterPos

  updateMarker: (markers) ->
    @_removeAllMarker()
    @_markers = markers.map (marker) =>
      @createMarker {lat: marker.lat, lng: marker.lng}, marker.id
    @_fitBounds markers
    @_setCenterPos()

  createMap: (coords) ->
    opts =
      minZoom: 5
      zoom: 13
      center: new google.maps.LatLng @_centerPos.lat, @_centerPos.lng
    new google.maps.Map findDOMNode(@refs.mapCanvas), opts

  createMarker: (coords, id) ->
    marker = new google.maps.Marker
      position: new google.maps.LatLng coords.lat, coords.lng
      map: @_map
    google.maps.event.addListener marker, 'click', ->
      location.hash = "/shop/#{id}"
    return marker

  _setCenterPos: ->
    center = @_map.getCenter()
    @_centerPos.lat = center.lat()
    @_centerPos.lat = center.lng()

  _removeAllMarker: ->
    for marker in @_markers
      marker.setMap null
    @_markers.length = 0

  _fitBounds: (markers) ->
    bounds = new google.maps.LatLngBounds
    markers.forEach (marker) =>
      bounds.extend new google.maps.LatLng marker.lat, marker.lng
    @_map.fitBounds bounds

  componentWillReceiveProps: (nextProps) ->
    @updateMarker nextProps.markers if nextProps.markers.length > 0

  componentDidMount: ->
    { markers } = @props
    @_map = @createMap()
    @updateMarker markers if markers.length > 0

  render: ->
    <div className="google-map">
      <div ref="mapCanvas" className="google-map-canvas"></div>
    </div>
