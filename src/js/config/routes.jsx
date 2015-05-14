import React from 'react';
import { Route, Redirect, NotFoundRoute } from 'react-router';

import App from '../components/app';
import Search from '../components/search';
import Star from '../components/star';
import ShopDetail from '../components/shop-detail';
import NotFound from '../components/notfound';

export default (
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
)
