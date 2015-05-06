"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/footer.jade"

module.exports =
class Footer extends React.Component

  constructor: (props) ->
    super props

  render: -> template year: new Date().getFullYear()

  # @propTypes:
  # @defaultProps:
