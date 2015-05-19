"use strict"

React = require 'react'
jade = require 'react-jade'

actions = require '../../actions/actions'

template = jade.compileFile "#{__dirname}/../../templates/search-bar.jade"

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
    template
      isResultsByGeolocation: @props.isResultsByGeolocation
      onClickLocation: @_handleClickLocation
      onClickSearchKeyword: @_handleClickSearchKeyword
