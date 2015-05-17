import EventEmitter from 'eventemitter3';

import dispatcher from '../dispatcher/dispatcher';
import {SEARCH_SHOP} from '../constants/constants';

class ShopStore extends EventEmitter {

  constructor() {
    super();
    this._isSearchResultsByCurrentLocation = false;
    this._shops = [];
    dispatcher.register(this._handler.bind(this));
  }

  getShops() {
    return this._shops;
  }

  getSearchResultsByCurrentLocation() {
    return this._isSearchResultsByCurrentLocation;
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

  _setSearchResultsByCurrentLocation(isSearchResultsByCurrentLocation) {
    this._isSearchResultsByCurrentLocation = isSearchResultsByCurrentLocation;
  }

  _handler(action) {
    switch (action.actionType) {
      case SEARCH_SHOP:
        this._fetchShop(action.data.results.shop);
        this._setSearchResultsByCurrentLocation(
          action.isSearchResultsByCurrentLocation || false
        );
        this._emitChange();
        break;

      default:
    }
  }

}

export default new ShopStore
