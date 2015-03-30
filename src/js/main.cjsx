"use strict"

Promise = require 'promise'
React = require 'react'
_ = require 'lodash'
jsonp = require 'jsonp'
qs = require 'qs'

util = require './util'
App = require './components/app'

KEY = '1cc33a2a2f3f364a'
API_GOURMET = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/'
BASE_Q =
  key: KEY
  # large_area: 'Z011'
  format: 'jsonp'
  food: 'R012'
  type: 'lite'
  range: 5

# React.render <App data={} />, document.body
# <food>
# <code>R012</code>
# <name>そば・うどん</name>
# <food_category>
# <code>FK01</code>
# <name>和食</name>
# </food_category>
# </food>

# crel document.body, crel 'button', id: 'search-near', '近くの蕎麦屋を検索'
# searchNear = document.getElementById 'search-near'
#
# crel document.body, crel 'input', type: 'search', id: 'search-address', placeholder: '新宿'
# searchAddress = document.getElementById 'search-address'
#
# crel document.body, crel 'button', id: 'search-address-button', '住所キーワードで検索'
# searchAddressButton = document.getElementById 'search-address-button'
#
# crel document.body, crel 'div', id: 'dist'
# dist = document.getElementById 'dist'

eateries = document.querySelector '.eateries'

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

getSearchWord =  ->
  new Promise (resolve, reject) ->
    resolve searchAddress.value

# 仮
show = do ->
  _show = (data) ->
    _.forEach data, (v, k) ->
      if _.isPlainObject(v) or _.isArray(v)
        crel dist, crel 'h2', "===== #{k} ====="
        _show v
      else
        crel dist, crel 'p', "#{k} => #{v}"

Promise.resolve()
  .then getGeo
  .then (geoPos) ->
    getData _.assign _.cloneDeep(BASE_Q),
      lat: geoPos.coords.latitude
      lng: geoPos.coords.longitude
  .then (data) ->
    React.render <App data={data.results.shop[0]} />, document.body

# bean.on searchNear, 'click', (ev) ->
#   util.empty dist
#   Promise.resolve()
#     .then getGeo
#     .then (geoPos) ->
#       getData _.assign _.cloneDeep(BASE_Q),
#         lat: geoPos.coords.latitude
#         lng: geoPos.coords.longitude
#     .then (data) -> show data.results.shop
#
# bean.on searchAddressButton, 'click', ->
#   util.empty dist
#   Promise.resolve()
#     .then getSearchWord
#     .then (searchWord) ->
#       getData _.assign _.cloneDeep(BASE_Q),
#         keyword: searchWord
#     .then (data) ->
#       if data.results.results_returned is '0'
#         util.empty dist
#         crel dist, crel 'p', '見つかりませんでした'
#         return
#       show data.results.shop
