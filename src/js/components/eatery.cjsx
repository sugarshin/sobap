"use strict"

React = require 'react'

module.exports =
class Eatery
  propTypes:
    prop: React.PropTypes.bool

  componentDidMount: -> alert 'yes componentDidMount'

  render: -> <div className="eatery">Yes eatery</div>
