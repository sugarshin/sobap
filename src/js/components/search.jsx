import React from 'react';
import {RouteHandler} from 'react-router';

import SearchBar from './partials/search-bar';
import GoogleMap from './partials/google-map';
import Shops from './partials/shops';

import actions from '../actions/actions';
import shopStore from '../stores/shop-store';
import starredShopStore from '../stores/starred-shop-store';

export default class Search extends React.Component {

  // static get propTypes() {
  //   return {
  //
  //   };
  // }
  //
  // static get defaultProps() {
  //   return {
  //
  //   };
  // }

  constructor(props) {
    super(props);

    this.state = {
      shops: shopStore.getShops(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    };
  }

  _handleClickLocation() {
    actions.searchShopByLocation();
  }

  _handleClickSearchKeyword(value) {
    actions.searchShopByKeyword(value);
  }

  _handleClickStar(e) {
    actions.updateStarredShop(e.currentTarget.id);
  }

  _changeShops() {
    this.setState({
      shops: shopStore.getShops()
    });
  }

  _changeStarredShops() {
    this.setState({
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    });
  }

  componentDidMount() {
    shopStore.addChangeListener(this._changeShops.bind(this));
    starredShopStore.addChangeListener(this._changeStarredShops.bind(this));
    actions.searchShopByLocation();
  }

  componentWillUnmount() {
    shopStore.removeChangeListener(this._changeShops.bind(this));
    starredShopStore.removeChangeListener(this._changeStarredShops.bind(this));
  }

  render() {
    return (
      <div>
        <SearchBar
          onClickLocation={this._handleClickLocation.bind(this)}
          onClickSearchKeyword={this._handleClickSearchKeyword.bind(this)}
        />
        <GoogleMap
          markers={this.state.shops.map(shop => {
            return {
              lat: shop.lat,
              lng: shop.lng,
              id: shop.id
            };
          })}
        />
        <div className="main">
          <Shops
            key={'search-shops'}
            classNames={'shops'}
            shops={this.state.shops}
            onClickStar={this._handleClickStar.bind(this)}
            starredIDs={this.state.starredIDs}
          />
        </div>
        <RouteHandler />
      </div>
    );
  }

}
