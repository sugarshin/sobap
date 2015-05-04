"use strict"

React = require 'react'
jade = require 'react-jade'

template = jade.compileFile "#{__dirname}/../templates/search-bar.jade"

module.exports =
class SearchBar extends React.Component

  constructor: (props) ->
    super props

  _onClickLocation: =>
    @props.onClickLocation()
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  _onClickSearchKeyword: =>
    return unless v = @refs.inputSearch.getDOMNode().value # todo
    @props.onClickSearchKeyword v
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    template
      onClickLocation: @_onClickLocation
      onClickSearchKeyword: @_onClickSearchKeyword

SearchBar.propTypes =
  onClickLocation: React.PropTypes.func
  onClickSearchKeyword: React.PropTypes.func
# SearchBar.defaultProps =
