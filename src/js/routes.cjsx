"use strict"

React = require 'react'
{ Route, Redirect, NotFoundRoute } = require 'react-router'

App = require './components/app'
Search = require './components/search'
Star = require './components/star'
# Shop = require './components/shop'
NotFound = require './components/notfound'

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
    <NotFoundRoute handler={NotFound} />
  </Route>
