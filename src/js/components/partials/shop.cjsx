"use strict"

React = require 'react'
{ Link } = require 'react-router'

StarButton = require './star-button'
actions = require '../../actions/actions'
{
  gmapsApiKey
  vcBaseUrl
  vcSid
  vcPid
} = require '../../config/settings'

module.exports =
class Shop extends React.Component

  @propTypes:
    data: React.PropTypes.object
    isStarred: React.PropTypes.bool

  # @defaultProps:

  constructor: (props) ->
    super props

  _handleClickStar: (e) =>
    actions.updateStarredShop e.currentTarget.id

  _createVCURL: (url) =>
    encodeUrl = encodeURIComponent url
    return "#{vcBaseUrl}?sid=#{vcSid}&pid=#{vcPid}&vc_url=#{encodeUrl}"

  render: ->
    { data, isStarred } = @props
    latlng = "#{data.lat},#{data.lng}"

    <div className="shop">
      <h3 className="shop-name">
        <Link to="shop" params={id: data.id}>
          <span>{data.name}</span>
          <img
            src="http://ad.jp.ap.valuecommerce.com/servlet/gifbanner?sid=3210627&pid=883436145"
            height="0"
            width="0"
            border="0"
          />
          <span className="octicon octicon-info"></span>
        </Link>
      </h3>
      <p className="shop-address">{data.address}</p>

      <div className="shop-g-static-map">
        <a href={"https://maps.google.co.jp/maps?q=#{latlng}"} target="_blank">
          <img
            src={"http://maps.googleapis.com/maps/api/staticmap?center=#{latlng}&zoom=15&markers=color:white%7C#{latlng}&size=320x180&scale=2&key=#{gmapsApiKey}&sensor=false"}
          />
          <span className="octicon octicon-link-external"></span>
        </a>
      </div>

      <div className="shop-catch-container">
        <p>{data.catch}</p>
        <p>{data.genre.catch}</p>
        <p>{data.food.catch}</p>
      </div>

      <div className="shop-link-external">
        <a className="btn" href={"//www.google.com/search?q=#{data.name}"} target="_blank">
          <span>Google</span>
          <span className="octicon octicon-link-external"></span>
        </a>
        <a className="btn" href={@_createVCURL data.urls.pc} target="_blank">
          <img
            src="http://ad.jp.ap.valuecommerce.com/servlet/gifbanner?sid=3210627&pid=883436145"
            height="0"
            width="0"
            border="0"
          />
          <span>Hotpepper</span>
          <span className="octicon octicon-link-external"></span>
        </a>
      </div>
      {
        if data.shop_detial_memo or data.other_memo
          <div className="shop-memo-container">
            <p>{data.shop_detial_memo}</p>
            <p>{data.other_memo}</p>
          </div>
      }
      <StarButton id={data.id} isStarred={isStarred} />
    </div>
