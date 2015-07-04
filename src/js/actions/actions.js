import Promise from 'bluebird';
import assign from 'object-assign';
import includes from 'lodash.includes';
import remove from 'lodash.remove';
import partitionSize from 'partition-size';
import co from 'co';

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
    co(function* () {
      try {
        const data = yield this._requestShopData({id});
        dispatcher.dispatch({
          actionType: UPDATE_SHOP_DETAIL,
          data
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  searchShopByLocation() {
    co(function* () {
      try {
        const pos = yield geolocation();
        const lat = pos.coords.latitude,
              lng = pos.coords.longitude;

        let data = yield this._requestShopData({lat, lng}, TYPE_LITE);
        data.isResultsByGeolocation = true;

        dispatcher.dispatch({
          actionType: SEARCH_SHOP,
          data: data
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  searchShopByKeyword(keyword) {
    co(function* () {
      try {
        const data = yield this._requestShopData({keyword}, TYPE_LITE);

        dispatcher.dispatch({
          actionType: SEARCH_SHOP,
          data: data
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  fetchStarredShop() {
    co(function* () {
      try {
        const shopIDs = yield localStorage(STARRED_SHOP_IDS_KEY);
        if (shopIDs.length === 0) return; // todo

        const dataList = yield Promise.all(
          partitionSize(shopIDs, maxMultiRequestByID).map(ids => {
            return this._requestShopData({id: ids}, TYPE_LITE);
          })
        );

        if (!dataList) return; // todo
        dispatcher.dispatch({
          actionType: FETCH_STARRED_SHOP,
          dataList
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  updateStarredShop(id) {
    co(function* () {
      try {
        const shopIDs = yield localStorage(STARRED_SHOP_IDS_KEY);

        if (includes(shopIDs, id)) {
          this.removeStarredShop(id);
        } else {
          this.addStarredShop(id);
        }
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  addStarredShop(id) {
    co(function* () {
      try {
        yield this._addStarredID(id);
        const data = yield this._requestShopData({id}, TYPE_LITE);

        dispatcher.dispatch({
          actionType: ADD_STARRED_SHOP,
          data
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  removeStarredShop(id) {
    co(function* () {
      try {
        yield this._removeStarredID(id);
        dispatcher.dispatch({
          actionType: REMOVE_STARRED_SHOP,
          id
        });
      } catch (err) {
        console.log(err);
      }
    }.bind(this));
  }

  _addStarredID(id) {
    return new Promise((resolve) => {
      localStorage(STARRED_SHOP_IDS_KEY).then(shopIDs => {
        shopIDs.push(id);
        localStorage(STARRED_SHOP_IDS_KEY, shopIDs)
        .then(() => { return resolve(id); });
      });
    });
  }

  _removeStarredID(id) {
    return new Promise((resolve) => {
      localStorage(STARRED_SHOP_IDS_KEY).then(shopIDs => {
        remove(shopIDs, i => i === id);
        localStorage(STARRED_SHOP_IDS_KEY, shopIDs)
        .then(() => { return resolve(id); });
      });
    });
  }

  _requestShopData(...query) {
    return new Promise((resolve, reject) => {
      const params = assign({}, baseQuery, ...query);
      request(gourmetApi, params)
      .then(resolve)
      .catch(reject);
    });
  }

}

export default new Actions();
