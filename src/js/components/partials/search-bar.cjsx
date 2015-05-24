"use strict"

React = require 'react'
classnames = require 'classnames'

actions = require '../../actions/actions'

module.exports =
class SearchBar extends React.Component

  @propTypes:
    isResultsByGeolocation: React.PropTypes.bool

  @defaultProps:
    isResultsByGeolocation: false

  constructor: (props) ->
    super props

  _handleClickLocation: =>
    actions.searchShopByLocation()

  _handleClickSearchKeyword: =>
    return unless v = React.findDOMNode(@refs.inputSearch).value # todo
    actions.searchShopByKeyword v

  render: ->
    { isResultsByGeolocation } = @props

    <div className="search-bar-container">
      <div className="search-bar">
        <div className={classnames 'search-near-button', 'is-active': isResultsByGeolocation}>
          <span className="mega-octicon octicon-location" onClick={@_handleClickLocation}></span>
        </div>
        <div className="search-keyword-container">
          <input type="search" ref="inputSearch" />
          <div className="search-keyword-button">
            <button type="button" onClick={@_handleClickSearchKeyword}>
              <span className="octicon octicon-search"></span>
            </button>
          </div>
        </div>
      </div>
    </div>
