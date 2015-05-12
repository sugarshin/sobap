"use strict"

React = require 'react'
{ Link } = require 'react-router'

module.exports =
class Header extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

  render: ->
    <header className="g-header">
      <h1><a href="./">SOBAP</a></h1>
      <div className="g-menu">
        <ul>
          <li>
            <Link to="search">
              <span className="octicon octicon-search"></span>
              <span>Search</span>
            </Link>
          </li>
          <li>
            <Link to="star">
              <span className="octicon octicon-star"></span>
              <span>Star</span>
            </Link>
          </li>
        </ul>
      </div>
    </header>
