"use strict"

React = require 'react'
{ FacebookButton, TwitterButton } = require '@sugarshin/react-social'

module.exports =
class Footer extends React.Component

  # @propTypes:

  # @defaultProps:

  constructor: (props) ->
    super props

  render: ->
    <footer className="g-footer">
      <div className="social-contailer">
        <FacebookButton
          className="social-btn social-fb btn"
          url={"#{location.origin}#{location.pathname}"}
        >
          <span>Share</span>
          <span className="octicon octicon-link-external"></span>
        </FacebookButton>

        <TwitterButton
          className="social-btn social-tw btn"
          text={document.title}
        >
          <span>Tweet</span>
          <span className="octicon octicon-link-external"></span>
        </TwitterButton>
      </div>
      <p className="copyright">
        <small>
          <span>&copy; {new Date().getFullYear()} </span>
          <a href="//github.com/sugarshin/sobap/" target="_blank">SOBAP beta</a>
          <span> | Powered by HOT PEPPER</span>
        </small>
      </p>
    </footer>
