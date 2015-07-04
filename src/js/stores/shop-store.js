import EventEmitter from 'eventemitter3';

import dispatcher from '../dispatcher/dispatcher';
import { SEARCH_SHOP } from '../constants/constants';

const CHANGE_EVENT = 'change';

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
    this.on(CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.off(CHANGE_EVENT, callback);
  }

  _emitChange() {
    this.emit(CHANGE_EVENT);
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

export default new ShopStore();
