import EventEmitter from 'eventemitter3';
import remove from 'lodash.remove';

import dispatcher from '../dispatcher/dispatcher';
import {FETCH_STARRED_SHOP} from '../constants/constants';

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

  _fetchShop(shops) {
    this._starredShops = shops;
  }

  _addShop(shop) {
    this._starredShops.push(shop);
  }

  _removeShop(id) {
    remove(this._starredShops, shop => { shop.id === id });
  }

  _handler(action) {
    switch (action.actionType) {
      case FETCH_STARRED_SHOP:
        if (action.data) {
          this._addShop(action.data.results.shop[0]);
        } else if (action.id) {
          this._removeShop(action.id);
        }
        this._emitChange();
        break;

      default:
    }
  }

}

export default new StarredShopStore
