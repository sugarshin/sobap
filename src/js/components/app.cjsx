"use strict"

React = require 'react'
EventEmitter = require 'eventemitter3'

Header = require './header'
GoogleMap = require './google-map'
Shops = require './shops'
Footer = require './footer'

Actions = require '../actions/actions'
ShopStore = require '../stores/shop-store'
StarredShopStore = require '../stores/starred-shop-store'

dispatcher = new EventEmitter

actions = new Actions dispatcher

shopStore = new ShopStore dispatcher
starredShopStore = new StarredShopStore dispatcher

module.exports =
class App extends React.Component

  constructor: (props) ->
    super props

    @state =
      shops: []
      starredShops: []

    shopStore.on 'change:shops', @_onChangeShops

    starredShopStore.on 'change:starredShops', @_onChangeStarredShops

  _onChangeShops: (currentGeo) =>
    @setState shops: shopStore.getShops()

    # Provisional
    geos = shopStore.getShops().map (el) ->
      lat: el.lat, lng: el.lng, id: el.id

    @refs.googleMap.updateByCurrentGeo geos, (if currentGeo? then currentGeo else null)

  _onChangeStarredShops: =>
    @setState starredShops: starredShopStore.getStarredShops()

  componentDidMount: ->
    actions.updateStarredShops()
    actions.updateShopsByGeo()

  onClickLocation: => actions.updateShopsByGeo()

  onClickSearchKeyword: =>
    # TODO
    v = React.findDOMNode @refs.header
        .querySelector 'input[type=search]'
        .value
    actions.updateShopsByKeyword v

  onClickStar: (e) =>
    actions.updateStarredShops e.currentTarget.id
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    <div className="app">
      <Header
        ref="header"
        onClickLocation={@onClickLocation}
        onClickSearchKeyword={@onClickSearchKeyword}
      />
      <GoogleMap ref="googleMap" />
      <div className="main">
        <Shops
          classNames={'shops starred-shops'}
          shops={@state.starredShops}
          onClickStar={@onClickStar}
          starredIDs={starredShopStore.getStarredIDs()}
        />
        <Shops
          classNames={'shops'}
          shops={@state.shops}
          onClickStar={@onClickStar}
          starredIDs={starredShopStore.getStarredIDs()}
        />
      </div>
      <Footer />
    </div>

# App.propTypes =
# App.defaultProps =
