# Shops

"use strict"

React = require 'react'
includes = require 'lodash.includes'
Shop = require './shop'

module.exports =
React.createClass

  getDefaultProps: -> shops: []

  render: ->
    <div className={@props.classNames}>
      {@props.shops.map (shop) =>
        <Shop
          key={shop.id}
          data={shop}
          onClickStar={@props.onClickStar}
          isStarred={includes @props.starredIDs, shop.id}
        />}
    </div>
