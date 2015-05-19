import EventEmitter from 'eventemitter3';

import dispatcher from '../dispatcher/dispatcher';
import {SEARCH_SHOP} from '../constants/constants';

class ShopStore extends EventEmitter {

  constructor() {
    super();
    this._isResultsByGeolocation = false;
    this._shops = [];
    dispatcher.register(this._handler.bind(this));
  }

  getShops() {
    return this._shops;
  }

  getResultsByGeolocation() {
    return this._isResultsByGeolocation;
  }

  addChangeListener(callback) {
    this.on('change', callback);
  }

  removeChangeListener(callback) {
    this.off('change', callback);
  }

  _emitChange() {
    this.emit('change');
  }

  _fetchShop(shops) {
    this._shops = shops;
  }

  _setResultsByGeolocation(isResultsByGeolocation) {
    this._isResultsByGeolocation = isResultsByGeolocation;
  }

  _handler(action) {
    switch (action.actionType) {
      case SEARCH_SHOP:
        this._fetchShop(action.data.results.shop);
        this._setResultsByGeolocation(
          action.data.isResultsByGeolocation || false
        );
        this._emitChange();
        break;

      default:
    }
  }

}

export default new ShopStore
