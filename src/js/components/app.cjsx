"use strict"

React = require 'react'
Header = require './header'
Footer = require './footer'
Eatery = require './eatery'

module.exports =
class App
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->
    console.log @

  render: ->
    <div>
      <Header />
      <div className="main">
        <div className="Eateries">
          <Eatery data={this.state.data} />
        </div>
      </div>
      <Footer />
    </div>
