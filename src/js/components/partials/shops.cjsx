"use strict"

React = require 'react'
includes = require 'lodash.includes'
# todo
randomstring = require 'randomstring'

Shop = require './shop'

module.exports =
class Shops extends React.Component

  @propTypes:
    classNames: React.PropTypes.string
    shops: React.PropTypes.array
    onClickStar: React.PropTypes.func
    starredIDs: React.PropTypes.array

  @defaultProps:
    shops: []

  constructor: (props) ->
    super props

  render: ->
    <div className={@props.classNames}>
      {@props.shops.map (shop) =>
        <Shop
          key={"#{shop.id}:#{randomstring.generate(16)}"}
          data={shop}
          onClickStar={@props.onClickStar}
          isStarred={includes @props.starredIDs, shop.id}
        />}
    </div>
