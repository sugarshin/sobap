# Shops

"use strict"

React = require 'react'
_ = require 'lodash'
Shop = require './shop'

module.exports =
React.createClass

  componentDidMount: ->

  getDefaultProps: -> shops: []

  render: ->
    <div className={@props.classNames}>
      {@props.shops.map (shop) =>
        <Shop
          key={shop.id}
          data={shop}
          onClickStar={@props.onClickStar}
          isStarred={_.includes @props.starredIDs, shop.id}
        />
      }
    </div>
