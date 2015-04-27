# Shops

"use strict"

React = require 'react'
includes = require 'lodash.includes'
map = require 'lodash.map'
Shop = require './shop'

module.exports =
React.createClass

  componentDidMount: ->

  getDefaultProps: -> shops: []

  render: ->
    <div className={@props.classNames}>
      {map @props.shops, (shop) =>
        <Shop
          key={shop.id}
          data={shop}
          onClickStar={@props.onClickStar}
          isStarred={includes @props.starredIDs, shop.id}
        />
      }
    </div>
