# Footer

"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile "#{__dirname}/../templates/footer.jade"

module.exports =
React.createClass

  componentDidMount: ->

  render: -> template()
