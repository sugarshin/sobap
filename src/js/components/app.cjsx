"use strict"

React = require 'react'
Header = require './header'
Eateries = require './eateries'
Footer = require './footer'

module.exports =
App = React.createClass
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->

  onClickLocation: ->

  render: ->
    <div>
      <Header onClickLocation={@onClickLocation} />
      <div id="map" className="map"></div>
      <div className="main">
        <Eateries />
      </div>
      <Footer />
    </div>
