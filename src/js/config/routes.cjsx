"use strict"

React = require 'react'
{ Route, Redirect, NotFoundRoute } = require 'react-router'

App = require '../components/app'
Search = require '../components/search'
Star = require '../components/star'
ShopDetail = require '../components/shop-detail'
NotFound = require '../components/notfound'

module.exports =
routes =
  <Route path="/" handler={App}>
    <Route
      name="search"
      path="search"
      handler={Search}
    />
    <Route
      name="star"
      path="star"
      handler={Star}
    />
    <Route
      name="shop"
      path="shop/:id"
      handler={ShopDetail}
    />
    <Redirect from="/" to="search" />
    <NotFoundRoute handler={NotFound} />
  </Route>
