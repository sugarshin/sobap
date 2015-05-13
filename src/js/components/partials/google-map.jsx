// TODO

import React from 'react';

export default class GoogleMap extends React.Component {

  static get propTypes() {
    return {
      markers: React.PropTypes.array
    };
  }

  // static get defaultProps() {
  //   return {
  //
  //   };
  // }

  constructor(props) {
    super(props);

    this._map = null;
    this._markers = [];
    // this._currentMarker = null;
    // this._infoWindow = null;
  }

  // _onUpdateMap(geos, currentGeo) {
  //   this.updateByCurrentGeo(geos, currentGeo);
  // }

  updateByCurrentGeo(geos, center) {
    // todo
    if (center) {
      this._map.panTo(new google.maps.LatLng(center.lat, center.lng));
    } else {
      let bounds = new google.maps.LatLngBounds;
      geos.forEach(el => {
        bounds.extend(new google.maps.LatLng(el.lat, el.lng));
      });
      this._map.fitBounds(bounds);
    }

    this.removeAllMarker();

    // todo
    geos.forEach(el => {
      let m = this.createMarker({
        latitude: el.lat,
        longitude: el.lng
      }, el.id);

      google.maps.event.addListener(m, 'click', () => {
        location.hash = `/shop/${m.url}`;
      });

      this._markers.push(m);
    });

  }

  removeAllMarker() {
    this._markers.forEach(marker => {
      marker.setMap(null);
    });
  }

  componentWillReceiveProps(nextProps) {
    // console.log '@props', @props.markers
    // console.log 'nextProps', nextProps.markers
    if (nextProps.markers.length > 0) {
      this.updateByCurrentGeo(nextProps.markers);
    }
  }

  componentDidMount() {
    // todo
    this._map = this.createMap({
      latitude: 35.6895,
      longitude: 139.69164
    });
    // google.maps.event.addListener @_map, 'zoom_changed', => @onZoomChange()
    // google.maps.event.addListener @_map, 'dragend', => @onDragEnd()
  }

  createMap(coords) {
    let mapOpts = {
      minZoom: 5,
      zoom: 13,
      center: new google.maps.LatLng(coords.latitude, coords.longitude)
    };

    return new google.maps.Map(React.findDOMNode(this.refs.mapCanvas), mapOpts);
  }

  createMarker(coords, id) {
    return new google.maps.Marker({
      position: new google.maps.LatLng(coords.latitude, coords.longitude),
      map: this._map,
      url: id
    });
  }

  // createInfoWindow() {
  //   let contentString = '<div class="InfoWindow"></div>';
  //   this._infoWindow = new google.maps.InfoWindow({
  //     map: this._map,
  //     anchor: this.marker,
  //     content: contentString
  //   });
  // }

  // onZoomChange() {}
  //
  // onDragEnd() {}

  render() {
    return (
      <div className="google-map">
        <div ref="mapCanvas" className="google-map-canvas"></div>
      </div>
    );
  }

}
