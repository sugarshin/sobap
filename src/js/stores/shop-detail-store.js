import EventEmitter from 'eventemitter3';

import dispatcher from '../dispatcher/dispatcher';
import { UPDATE_SHOP_DETAIL } from '../constants/constants';

// todo
import defaultShopDetail from './default-shop-detail'

const CHANGE_EVENT = 'change';

class ShopDetailStore extends EventEmitter {

  constructor() {
    super();
    this._shopDetail = defaultShopDetail;

    dispatcher.register(this._handler.bind(this));
  }

  getShop() {
    return this._shopDetail;
  }

  addChangeListener(callback) {
    this.on(CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.off(CHANGE_EVENT, callback);
  }

  _emitChange() {
    this.emit(CHANGE_EVENT);
  }

  _fetchShop(shop) {
    this._shopDetail = shop;
  }

  _handler(action) {
    switch (action.actionType) {
      case UPDATE_SHOP_DETAIL:
        this._fetchShop(action.data.results.shop[0]);
        this._emitChange();
        break;

      default:
    }
  }

}

export default new ShopDetailStore();
