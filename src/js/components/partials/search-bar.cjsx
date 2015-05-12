"use strict"

React = require 'react'
jade = require 'react-jade'

template = jade.compileFile "#{__dirname}/../../templates/search-bar.jade"

module.exports =
class SearchBar extends React.Component

  @propTypes:
    onClickLocation: React.PropTypes.func
    onClickSearchKeyword: React.PropTypes.func

  # @defaultProps:

  constructor: (props) ->
    super props

  _onClickLocation: =>
    @props.onClickLocation()

  _onClickSearchKeyword: =>
    return unless v = React.findDOMNode(@refs.inputSearch).value # todo
    @props.onClickSearchKeyword v

  render: ->
    template
      onClickLocation: @_onClickLocation
      onClickSearchKeyword: @_onClickSearchKeyword
