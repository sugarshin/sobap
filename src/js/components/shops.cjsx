# Shops

"use strict"

React = require 'react'
Shop = require './shop'

module.exports =
React.createClass

  componentDidMount: ->

  getDefaultProps: -> shops: []

  render: ->
    <div className="shops">
      {@props.shops.map (shop) -> <Shop key={shop.id} data={shop} />}
    </div>
