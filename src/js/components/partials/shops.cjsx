"use strict"

React = require 'react'
includes = require 'lodash.includes'

Shop = require './shop'

module.exports =
class Shops extends React.Component

  @propTypes:
    classNames: React.PropTypes.string
    shops: React.PropTypes.array
    starredIDs: React.PropTypes.array

  @defaultProps:
    shops: []

  constructor: (props) ->
    super props

  render: ->
    <div className={@props.classNames}>
      {@props.shops.map (shop) =>
        <Shop
          key={shop.id}
          data={shop}
          isStarred={includes @props.starredIDs, shop.id}
        />}
    </div>
