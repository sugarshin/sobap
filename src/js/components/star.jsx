import React from 'react';
import { RouteHandler } from 'react-router';

import Shops from './partials/shops';

import starredShopStore from '../stores/starred-shop-store';

export default class Star extends React.Component {

  // static get propTypes() { return {}; }
  //
  // static get defaultProps() { return {}; }

  constructor(props) {
    super(props);

    this.state = {
      shops: starredShopStore.getShops(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    };

    this._boundChangeStarredShops = this._changeStarredShops.bind(this);
  }

  _changeStarredShops() {
    this.setState({
      shops: starredShopStore.getShops(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    });
  }

  componentDidMount() {
    starredShopStore.addChangeListener(this._boundChangeStarredShops);
  }

  componentWillUnmount() {
    starredShopStore.removeChangeListener(this._boundChangeStarredShops);
  }

  render() {
    const { shops, starredIDs } = this.state;

    return (
      <div style={{padding: '40px 0 0'}}>
        <div className="main">
          <Shops
            key={'starred-shops'}
            classNames={'shops starred-shops'}
            shops={shops}
            starredIDs={starredIDs}
          />
        </div>
        <RouteHandler />
      </div>
    );
  }

}
