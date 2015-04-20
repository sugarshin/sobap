# Shops

"use strict"

React = require 'react'
Shop = require './shop'

module.exports =
React.createClass

  componentDidMount: ->

  getDefaultProps: -> shops: []

  # onClickStar: (ev, id) ->
  #   console.log ev.target
  #   console.log id

  render: ->
    <div className="shops">
      {@props.shops.map (shop) =>
        <Shop
          key={shop.id}
          data={shop}
          onClickStar={@props.onClickStar}
        />
      }
    </div>
