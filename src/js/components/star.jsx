import React from 'react';
import {RouteHandler} from 'react-router';

import Shops from './partials/shops';

import actions from '../actions/actions';
import starredShopStore from '../stores/starred-shop-store';

export default class Star extends React.Component {

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
      shops: starredShopStore.getShops(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    };
  }

  _changeStarredShops() {
    this.setState({
      shops: starredShopStore.getShops(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    });
  }

  _handleClickStar(e) {
    actions.updateStarredShop(e.currentTarget.id);
  }

  componentDidMount() {
    starredShopStore.addChangeListener(this._changeStarredShops.bind(this));
  }

  componentWillUnmount() {
    starredShopStore.removeChangeListener(this._changeStarredShops.bind(this));
  }

  render() {
    return (
      <div style={{padding: '40px 0 0'}}>
        <div className="main">
          <Shops
            key={'starred-shops'}
            classNames={'shops starred-shops'}
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
