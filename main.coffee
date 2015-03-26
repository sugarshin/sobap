Promise = require 'promise'
_ = require 'lodash'
jsonp = require 'jsonp'
qs = require 'qs'
crel = require 'crel'
bean = require 'bean'

KEY = '1cc33a2a2f3f364a'
API_GOURMET = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/'

crel document.body, crel 'button', id: 'search', '近くの蕎麦屋を検索'
search = document.getElementById 'search'

crel document.body, crel 'div', id: 'dist'
dist = document.getElementById 'dist'

getGeo = ->
  new Promise (resolve, reject) ->
    navigator.geolocation.getCurrentPosition (pos, err) ->
      if err? then reject err
      resolve pos

getData = (query) ->
  new Promise (resolve, reject) ->
    jsonp API_GOURMET,
      param: qs.stringify(query) + '&callback' # todo
    , (err, data) ->
      if err?
        console.error err
        reject err
      console.debug data
      resolve data

show = do ->
  _show = (data) ->
    new Promise (resolve, reject) ->
      _.forEach data, (v, k) ->
        if _.isPlainObject(v) or _.isArray(v)
          crel dist, crel 'h2', "===== #{k} ====="
          _show v
        else
          crel dist, crel 'p', "#{k} => #{v}"
      resolve data

bean.one search, 'click', (ev) ->
  Promise.resolve()
    .then getGeo
    .then (geoPos) ->
      q =
        key: KEY
        large_area: 'Z011'
        format: 'jsonp'
        type: 'lite'
        keyword: '蕎麦'
        range: 5
        lat: geoPos.coords.latitude
        lng: geoPos.coords.longitude
      getData q
    .then (data) -> show data.results.shop
