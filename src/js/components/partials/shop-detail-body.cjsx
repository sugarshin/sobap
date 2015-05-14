"use strict"

React = require 'react'
assign = require 'object-assign'
jade = require 'react-jade'

actions = require '../../actions/actions'

template = jade.compileFile "#{__dirname}/../../templates/shop-detail-body.jade"

module.exports =
class ShopDetailBody extends React.Component

  @propTypes:
    data: React.PropTypes.object
    isStarred: React.PropTypes.bool

  # @defaultProps:

  constructor: (props) ->
    super props

  _handleClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id

  render: ->
    template assign {}, @props, onClickStar: @_handleClickStar
