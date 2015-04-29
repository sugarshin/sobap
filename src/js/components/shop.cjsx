# Shop

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/shop.jade"

module.exports =
React.createClass
  propTypes:
    data: React.PropTypes.object
    onClickStar: React.PropTypes.func
    isStarred: React.PropTypes.bool

  render: -> template @props
