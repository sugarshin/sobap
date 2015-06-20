"use strict"

React = require 'react'
includes = require 'lodash.includes'

Shop = require './shop'

Component = React.Component
PropTypes = React.PropTypes

module.exports =
class Shops extends Component

  @propTypes:
    classNames: PropTypes.string
    shops: PropTypes.array
    starredIDs: PropTypes.array

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
