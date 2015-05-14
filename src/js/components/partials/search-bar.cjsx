"use strict"

React = require 'react'
jade = require 'react-jade'

actions = require '../../actions/actions'

template = jade.compileFile "#{__dirname}/../../templates/search-bar.jade"

module.exports =
class SearchBar extends React.Component

  @propTypes:
    onClickLocation: React.PropTypes.func
    onClickSearchKeyword: React.PropTypes.func

  # @defaultProps:

  constructor: (props) ->
    super props

  _handleClickLocation: =>
    actions.searchShopByLocation()

  _handleClickSearchKeyword: =>
    return unless v = React.findDOMNode(@refs.inputSearch).value # todo
    actions.searchShopByKeyword v

  render: ->
    template
      onClickLocation: @_handleClickLocation
      onClickSearchKeyword: @_handleClickSearchKeyword
