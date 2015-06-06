import React from 'react';
import { RouteHandler } from 'react-router';
import includes from 'lodash.includes';

import ShopDetailBody from './partials/shop-detail-body';

import actions from '../actions/actions';
import shopDetailStore from '../stores/shop-detail-store';
import starredShopStore from '../stores/starred-shop-store';

export default class ShopDetail extends React.Component {

  // static get propTypes() { return {}; }
  //
  // static get defaultProps() { return {}; }

  constructor(props) {
    super(props);

    this.state = {
      shop: shopDetailStore.getShop(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    };

    this._boundChangeShop = this._changeShop.bind(this);
    this._boundChangeStarredShops = this._changeStarredShops.bind(this);
  }

  componentDidMount() {
    shopDetailStore.addChangeListener(this._boundChangeShop);
    starredShopStore.addChangeListener(this._boundChangeStarredShops);

    actions.updateShopDetail(this.props.params.id);
  }

  componentWillUnmount() {
    shopDetailStore.removeChangeListener(this._boundChangeShop);
    starredShopStore.removeChangeListener(this._boundChangeStarredShops);
  }

  _changeShop() {
    this.setState({
      shop: shopDetailStore.getShop()
    });
  }

  _changeStarredShops() {
    this.setState({
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    });
  }

  render() {
    const { shop, starredIDs } = this.state;

    return (
      <ShopDetailBody
        data={shop}
        isStarred={includes(starredIDs, this.props.params.id)}
      />
    );
  }

}
