"use strict"

React = require 'react'
Header = require './header'
Shops = require './shops'
Footer = require './footer'

module.exports =
App = React.createClass

  componentDidMount: ->

  onClickLocation: -> @refs.shops.updateShopsByGeolocation()

  onClickSearchKeyword: ->
    v = React.findDOMNode(@refs.header)
        .querySelector('input[type=search]')
        .value
    @refs.shops.updateShopsByKeyword v

  render: ->
    <div>
      <Header
        ref="header"
        onClickLocation={@onClickLocation}
        onClickSearchKeyword={@onClickSearchKeyword}
      />
      <div id="map" className="map"></div>
      <div className="main">
        <Shops ref="shops" />
      </div>
      <Footer />
    </div>
