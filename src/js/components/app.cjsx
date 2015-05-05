"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

Header = require './header'
Footer = require './footer'

{ actions, store } = require '../flux'

module.exports =
class App extends React.Component

  constructor: (props) ->
    super props

    @state =
      shops: store.getShops()
      starredShops: store.getStarredShops()
      shopDetail: store.getShopDetail()

    store.on 'change:shops', @_onChangeShops
    store.on 'change:starredShops', @_onChangeStarredShops
    store.on 'change:shopDetail', @_onChangeShopDetail

  _onChangeShopDetail: =>
    @setState shopDetail: store.getShopDetail()

  _onChangeShops: (currentGeo) =>
    @setState shops: store.getShops()

    # Provisional
    geos = @state.shops.map (el) ->
      lat: el.lat, lng: el.lng, id: el.id

    actions.updateMap geos, (if currentGeo? then currentGeo else null)

  _onChangeMap: (geos, currentGeo) =>
    @setState mapData: mapStore.get()

  _onChangeStarredShops: =>
    @setState starredShops: store.getStarredShops()

  componentWillMount: ->
    actions.updateStarredShops()
    actions.updateShopsByGeo()

  onUpdateShopDetail: (id) =>
    actions.updateShopDetail id

  onClickLocation: => actions.updateShopsByGeo()

  onClickSearchKeyword: (value) =>
    actions.updateShopsByKeyword value

  onClickStar: (id) =>
    actions.updateStarredShops id
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    <div className="app">
      <Header />
      <RouteHandler
        shops={@state.shops}
        starredShops={@state.starredShops}
        onClickLocation={@onClickLocation}
        onClickSearchKeyword={@onClickSearchKeyword}
        onClickStar={@onClickStar}
        onUpdateShopDetail={@onUpdateShopDetail}
        starredIDs={store.getStarredIDs()}
        shopDetail={@state.shopDetail}
      />
      <Footer />
    </div>

# App.propTypes =
# App.defaultProps =
