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

    shopStore.on 'change:shops', (data, currentGeo) =>
      @setState shops: data.results.shop

      geos = data.results.shop.map (el) ->
        lat: el.lat, lng: el.lng, id: el.id

      @refs.googleMap.updateByCurrentGeo (if currentGeo? then currentGeo else geos[0]), geos

    starredShopStore.on 'change:starredShops', (shop) =>
      @setState starredShops: shop

  componentDidMount: ->
    actions.updateStarredShop()
    actions.updateShopsByGeo()

  onClickLocation: => actions.updateShopsByGeo()

  onClickSearchKeyword: =>
    # TODO
    v = React.findDOMNode @refs.header
        .querySelector 'input[type=search]'
        .value
    actions.updateShopsByKeyword v

  onClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id
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
