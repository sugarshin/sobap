import Promise from 'bluebird';
import assign from 'object-assign';
import includes from 'lodash.includes';
import remove from 'lodash.remove';

import dispatcher from '../dispatcher/dispatcher';
import request from '../utils/request';
import geolocation from '../utils/geolocation';
import localStorage from '../utils/local-storage';
import {gourmetApi, baseQuery} from '../config/settings';

import {
  SEARCH_SHOP,
  FETCH_STARRED_SHOP,
  UPDATE_SHOP_DETAIL
} from '../constants/constants';

const TYPE_LITE = {type: 'lite'};
const STARRED_SHOP_KEY = 'starredShopsIDs';

class Actions {

  updateShopDetail(id) {
    this._requestShopData({id: id}).then((data) => {
      dispatcher.dispatch({
        actionType: UPDATE_SHOP_DETAIL,
        data: data
      });
    });
  }

  searchShopByLocation() {
    Promise.resolve()
    .then(geolocation)
    .then((pos) => {
      this._requestShopData({
        lat: pos.coords.latitude,
        lng: pos.coords.longitude
      }, TYPE_LITE).then((data) => {
        dispatcher.dispatch({
          actionType: SEARCH_SHOP,
          data: data
        });
      });
    });
  }

  searchShopByKeyword(keyword) {
    this._requestShopData({
      keyword: keyword
    }, TYPE_LITE).then((data) => {
      dispatcher.dispatch({
        actionType: SEARCH_SHOP,
        data: data
      });
    });
  }

  fetchStarredShop() {
    localStorage(STARRED_SHOP_KEY).then((shopIDs) => {
      shopIDs.forEach(id => {
        this._requestShopData({
          id: id
        }, TYPE_LITE).then((data) => {
          dispatcher.dispatch({
            actionType: FETCH_STARRED_SHOP,
            data: data
          });
        });
      });
    });
  }

  updateStarredShop(id) {
    localStorage(STARRED_SHOP_KEY).then((shopIDs) => {
      if (includes(shopIDs, id)) {
        this._removeStarredShop(shopIDs, id);
      } else {
        this._addStarredShop(shopIDs, id);
      }
    });
  }

  _addStarredShop(shopIDs, id) {
    shopIDs.push(id);
    localStorage(STARRED_SHOP_KEY, shopIDs)
    .then((nextShopIDs) => {
      this._requestShopData({id: id}, TYPE_LITE).then((data) => {
        dispatcher.dispatch({
          actionType: FETCH_STARRED_SHOP,
          data: data
        });
      });
    });
  }

  _removeStarredShop(shopIDs, id) {
    remove(shopIDs, i => { i === id });
    localStorage(STARRED_SHOP_KEY, shopIDs)
    .then((nextShopIDs) => {
      dispatcher.dispatch({
        actionType: FETCH_STARRED_SHOP,
        id: id
      });
    });
  }

  _requestShopData(...query) {
    return new Promise((resolve, reject) => {
      let params = assign({}, baseQuery, ...query);
      request(gourmetApi, params)
      .then(resolve)
      .catch(reject);
    });
  }

}

export default new Actions
