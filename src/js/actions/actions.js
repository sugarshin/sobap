import Promise from 'bluebird';
import assign from 'object-assign';
import includes from 'lodash.includes';
import remove from 'lodash.remove';
import partitionSize from 'partition-size';

import dispatcher from '../dispatcher/dispatcher';
import request from '../utils/request';
import geolocation from '../utils/geolocation';
import localStorage from '../utils/local-storage';
import {
  gourmetApi,
  baseQuery,
  maxMultiRequestByID
} from '../config/settings';

import {
  SEARCH_SHOP,
  FETCH_STARRED_SHOP,
  ADD_STARRED_SHOP,
  REMOVE_STARRED_SHOP,
  UPDATE_SHOP_DETAIL
} from '../constants/constants';

const TYPE_LITE = {type: 'lite'};
const STARRED_SHOP_IDS_KEY = 'starredShopsIDs';

class Actions {

  updateShopDetail(id) {
    Promise.resolve()
    .then(() => { return this._requestShopData({id: id}); })
    .then((data) => {
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
      return this._requestShopData({
        lat: pos.coords.latitude,
        lng: pos.coords.longitude
      }, TYPE_LITE);
    })
    .then((data) => {
      data.isResultsByGeolocation = true;
      dispatcher.dispatch({
        actionType: SEARCH_SHOP,
        data: data
      });
    });
  }

  searchShopByKeyword(keyword) {
    Promise.resolve()
    .then(() => {
      return this._requestShopData({
        keyword: keyword
      }, TYPE_LITE);
    })
    .then((data) => {
      dispatcher.dispatch({
        actionType: SEARCH_SHOP,
        data: data
      });
    });
  }

  fetchStarredShop() {
    Promise.resolve()
    .then(() => { return localStorage(STARRED_SHOP_IDS_KEY); })
    .then((shopIDs) => {
      if (shopIDs.length === 0) return; // todo
      return Promise.all(
        partitionSize(shopIDs, maxMultiRequestByID).map(ids => {
          return this._requestShopData({
            id: ids
          }, TYPE_LITE);
        })
      );
    })
    .then((dataList) => {
      dispatcher.dispatch({
        actionType: FETCH_STARRED_SHOP,
        dataList: dataList
      });
    });
  }

  updateStarredShop(id) {
    Promise.resolve()
    .then(() => { return localStorage(STARRED_SHOP_IDS_KEY); })
    .then((shopIDs) => {
      if (includes(shopIDs, id)) {
        this.removeStarredShop(id);
      } else {
        this.addStarredShop(id);
      }
    });
  }

  addStarredShop(id) {
    Promise.resolve()
    .then(() => { return this._addStarredID(id); })
    .then((id) => { return this._requestShopData({id: id}, TYPE_LITE); })
    .then((data) => {
      dispatcher.dispatch({
        actionType: ADD_STARRED_SHOP,
        data: data
      });
    });
  }

  removeStarredShop(id) {
    Promise.resolve()
    .then(() => { return this._removeStarredID(id); })
    .then((id) => {
      dispatcher.dispatch({
        actionType: REMOVE_STARRED_SHOP,
        id: id
      });
    });
  }

  _addStarredID(id) {
    return new Promise((resolve) => {
      localStorage(STARRED_SHOP_IDS_KEY).then((shopIDs) => {
        shopIDs.push(id);
        localStorage(STARRED_SHOP_IDS_KEY, shopIDs)
        .then(() => { return resolve(id); });
      });
    });
  }

  _removeStarredID(id) {
    return new Promise((resolve) => {
      localStorage(STARRED_SHOP_IDS_KEY).then((shopIDs) => {
        remove(shopIDs, i => i === id);
        localStorage(STARRED_SHOP_IDS_KEY, shopIDs)
        .then(() => { return resolve(id); });
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
