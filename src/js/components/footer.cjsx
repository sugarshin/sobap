"use strict"

React = require 'react'
jade = require 'react-jade'
template = jade.compileFile __dirname + '/../templates/footer.jade'

module.exports =
class Footer
  # propTypes:
  #   prop: React.PropTypes.bool

  componentDidMount: ->
    console.log @

  render: -> template()
