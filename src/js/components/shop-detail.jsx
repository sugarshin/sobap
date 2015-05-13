import React from 'react';
import {RouteHandler} from 'react-router';
import includes from 'lodash.includes';

import ShopDetailBody from './partials/shop-detail-body';

import actions from '../actions/actions';
import shopDetailStore from '../stores/shop-detail-store';
import starredShopStore from '../stores/starred-shop-store';

export default class ShopDetail extends React.Component {

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
      shop: shopDetailStore.getShop(),
      starredIDs: starredShopStore.getShops().map(shop => shop.id)
    };
  }

  _handleClickStar(e) {
    actions.updateStarredShop(e.currentTarget.id);
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

  componentDidMount() {
    shopDetailStore.addChangeListener(this._changeShop.bind(this));
    starredShopStore.addChangeListener(this._changeStarredShops.bind(this));
    actions.updateShopDetail(this.props.params.id);
  }

  componentWillUnmount() {
    shopDetailStore.removeChangeListener(this._changeShop.bind(this));
    starredShopStore.removeChangeListener(this._changeStarredShops.bind(this));
  }

  render() {
    return (
      <ShopDetailBody
        data={this.state.shop}
        onClickStar={this._handleClickStar.bind(this)}
        isStarred={includes(this.state.starredIDs, this.props.params.id)}
      />
    );
  }

}
