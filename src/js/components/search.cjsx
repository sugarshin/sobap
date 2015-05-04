"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

SearchBar = require './search-bar'
GoogleMap = require './google-map'
Shops = require './shops'

module.exports =
class Search extends React.Component

  constructor: (props) ->
    super props

  _onClickLocation: =>
    @props.onClickLocation()
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  _onClickSearchKeyword: (value) =>
    @props.onClickSearchKeyword value
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  _onClickStar: (e) =>
    @props.onClickStar e.currentTarget.id
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    <div>
      <SearchBar
        onClickLocation={@_onClickLocation}
        onClickSearchKeyword={@_onClickSearchKeyword}
      />
      <GoogleMap />
      <div className="main">
        <Shops
          classNames={'shops'}
          shops={@props.shops}
          onClickStar={@_onClickStar}
          starredIDs={@props.starredIDs}
        />
      </div>
      <RouteHandler />
    </div>

Search.propTypes =
  shops: React.PropTypes.array
  starredIDs: React.PropTypes.array
  onClickLocation: React.PropTypes.func
  onClickSearchKeyword: React.PropTypes.func
  onClickStar: React.PropTypes.func
# Search.defaultProps =
