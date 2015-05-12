import EventEmitter from 'eventemitter3';
import remove from 'lodash.remove';

import dispatcher from '../dispatcher/dispatcher';
import {
  ADD_STARRED_SHOP,
  REMOVE_STARRED_SHOP
} from '../constants/constants';

class StarredShopStore extends EventEmitter {

  constructor() {
    super();
    this._starredShops = [];
    dispatcher.register(this._handler.bind(this));
  }

  getShops() {
    return this._starredShops;
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

  _addShop(shop) {
    this._starredShops.push(shop);
  }

  _removeShop(id) {
    remove(this._starredShops, shop => shop.id === id);
  }

  _handler(action) {
    switch (action.actionType) {
      case ADD_STARRED_SHOP:
        this._addShop(action.data.results.shop[0]);
        this._emitChange();
        break;

      case REMOVE_STARRED_SHOP:
        this._removeShop(action.id);
        this._emitChange();
        break;

      default:
    }
  }

}

export default new StarredShopStore
