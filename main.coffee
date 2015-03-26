Promise = require 'promise'
_ = require 'lodash'
jsonp = require 'jsonp'
qs = require 'qs'

KEY = '1cc33a2a2f3f364a'
API = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/'

dist = document.createElement 'div'
document.body.appendChild dist

getGeo = ->
  new Promise (resolve, reject) ->
    navigator.geolocation.getCurrentPosition (pos, err) ->
      if err? then reject err
      resolve pos

getData = (pos) ->
  q =
    key: KEY
    large_area: 'Z011'
    format: 'jsonp'
    type: 'lite'
    lat: pos.coords.latitude
    lng: pos.coords.longitude
  new Promise (resolve, reject) ->
    jsonp API,
      param: qs.stringify(q) + '&callback' # todo
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
          _show v
        else
          p = document.createElement 'p'
          p.textContent = "#{k} => #{v}"
          dist.appendChild p
      resolve data

Promise.resolve()
  .then getGeo
  .then getData
  .then show
