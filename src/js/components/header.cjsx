"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/header.jade"

module.exports =
class Header extends React.Component

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
    @props.onClickSearchKeyword()
    return
    # Returning `false` from an event handler is
    # deprecated and will be ignored in a future release.
    # Instead, manually call e.stopPropagation() or e.preventDefault(), as appropriate.
    # 上記 warning の回避のため

  render: ->
    template
      onClickLocation: @_onClickLocation
      onClickSearchKeyword: @_onClickSearchKeyword

# Header.propTypes =
# Header.defaultProps =
