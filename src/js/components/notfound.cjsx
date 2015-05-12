"use strict"

React = require 'react'
{ RouteHandler } = require 'react-router'

module.exports =
class NotFound extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

  render: ->
    <div className="main not-found">
      <h2>404 Not Found <span className="mega-octicon octicon-megaphone"></span></h2>
      <p>Page Not Found...</p>
      <RouteHandler />
    </div>
