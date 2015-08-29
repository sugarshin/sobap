import React, { Component } from 'react';
import { RouteHandler } from 'react-router';

import SearchBar from './partials/search-bar';
import GoogleMap from './partials/google-map';
import Shops from './partials/shops';

import shopStore from '../stores/shop-store';
import starredShopStore from '../stores/starred-shop-store';

export default class Search extends Component {

  constructor(props) {
    super(props);

    const shops = shopStore.getShops();
    this.state = {
      isResultsByGeolocation: shopStore.getResultsByGeolocation(),
      shops,
      starredIDs: starredShopStore.getShops().map(shop => shop.id),
      markers: shops.map(shop => {
        const { lat, lng, id } = shop;
        return { lat: +lat, lng: +lng, id };
      })
    };

    this._boundChangeShops = this._changeShops.bind(this);
    this._boundChangeStarredShops = this._changeStarredShops.bind(this);
  }

  componentDidMount() {
    shopStore.addChangeListener(this._boundChangeShops);
    starredShopStore.addChangeListener(this._boundChangeStarredShops);
  }

  componentWillUnmount() {
    shopStore.removeChangeListener(this._boundChangeShops);
    starredShopStore.removeChangeListener(this._boundChangeStarredShops);
  }

  _changeShops() {
    const shops = shopStore.getShops();
    this.setState({
      isResultsByGeolocation: shopStore.getResultsByGeolocation(),
      shops,
      markers: shops.map(shop => {
        const { lat, lng, id } = shop;
        return { lat: +lat, lng: +lng, id };
      })
    });
  }

  _changeStarredShops() {
    this.setState({
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    });
  }

  render() {
    const {
      isResultsByGeolocation,
      markers,
      shops,
      starredIDs
    } = this.state;

    return (
      <div>
        <SearchBar isResultsByGeolocation={isResultsByGeolocation} />
        <GoogleMap markers={markers} />
        <div className="main">
          <Shops key={'search-shops'}
                 classNames={'shops'}
                 shops={shops}
                 starredIDs={starredIDs} />
        </div>
        <RouteHandler />
      </div>
    );
  }

}
