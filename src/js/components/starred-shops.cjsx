# StarredShops

"use strict"

React = require 'react'
StarredShop = require './starred-shop'

module.exports =
React.createClass

  componentDidMount: ->

  getDefaultProps: -> shops: []

  # onClickStar: (ev, id) ->
  #   console.log ev.target
  #   console.log id

  render: ->
    <div className="shops starred-shops">
      {@props.shops.map (shop) =>
        <StarredShop
          key={shop.id}
          data={shop}
          onClickStar={@props.onClickStar}
        />
      }
    </div>
