"use strict"

React = require 'react'
assign = require 'object-assign'
jade = require 'react-jade'

actions = require '../../actions/actions'

Component = React.Component
PropTypes = React.PropTypes

template = jade.compileFile "#{__dirname}/../../templates/shop.jade"

module.exports =
class Shop extends Component

  @propTypes:
    data: PropTypes.object
    isStarred: PropTypes.bool

  # @defaultProps:

  constructor: (props) ->
    super props

  _handleClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id

  render: ->
    template assign {}, @props, onClickStar: @_handleClickStar
