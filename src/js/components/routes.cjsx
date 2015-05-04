React = require 'react'
{ Route, Redirect } = require 'react-router'

App = require './app'
Search = require './search'
Star = require './star'
# Shop = require './shop'
# NotFound = require './notfound.cjsx'

module.exports =
routes =
  <Route path="/" handler={App}>
    <Route
      name="search"
      path="search"
      handler={Search}
      props={
        shops: @shops
        starredIDs: @starredIDs
        onClickLocation: @onClickLocation
        onClickSearchKeyword: @onClickSearchKeyword
        onClickStar: @onClickStar
      }
    />
    <Route
      name="star"
      path="star"
      handler={Star}
      props={
        starredShops: @starredShops
        starredIDs: @starredIDs
        onClickStar: @onClickStar
      }
    />
    <Redirect from="/" to="search" />
  </Route>
