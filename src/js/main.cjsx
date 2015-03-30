"use strict"

React = require 'react'
App = require './components/app'

# 仮
# show = do ->
#   _show = (data) ->
#     _.forEach data, (v, k) ->
#       if _.isPlainObject(v) or _.isArray(v)
#         crel dist, crel 'h2', "===== #{k} ====="
#         _show v
#       else
#         crel dist, crel 'p', "#{k} => #{v}"

React.render <App />, document.body
