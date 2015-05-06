"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

Shops = require './shops'

# { actions } = require '../flux'

module.exports =
class Star extends React.Component

  constructor: (props) ->
    super props

  _onClickStar: (e) =>
    @props.onClickStar e.currentTarget.id
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    <div style={
      padding: '40px 0 0'
    }>
      <div className="main">
        <Shops
          classNames={'shops starred-shops'}
          shops={@props.starredShops}
          onClickStar={@_onClickStar}
          starredIDs={@props.starredIDs}
        />
      </div>
      <RouteHandler />
    </div>

  @propTypes:
    starredShops: React.PropTypes.array
    starredIDs: React.PropTypes.array
    onClickStar: React.PropTypes.func
  # @defaultProps:
