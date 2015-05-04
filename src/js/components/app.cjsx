"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

Header = require './header'
Footer = require './footer'

{ actions, shopStore, starredShopStore } = require '../flux'

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

    actions.updateMap geos, (if currentGeo? then currentGeo else null)

  _onChangeMap: (geos, currentGeo) =>
    @setState mapData: mapStore.get()

  _onChangeStarredShops: =>
    @setState starredShops: starredShopStore.getStarredShops()

  componentDidMount: ->
    actions.updateStarredShops()
    actions.updateShopsByGeo()

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
        starredIDs={starredShopStore.getStarredIDs()}
      />
      <Footer />
    </div>

# App.propTypes =
# App.defaultProps =
