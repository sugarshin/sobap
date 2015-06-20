import React, { Component } from 'react';
import { RouteHandler } from 'react-router';

import Header from './partials/header';
import Footer from './partials/footer';

import actions from '../actions/actions';

export default class App extends Component {

  constructor(props) {
    super(props);
  }

  componentDidMount() {
    actions.searchShopByLocation();
    actions.fetchStarredShop();
  }

  render() {
    return (
      <div className="app">
        <Header />
        <RouteHandler />
        <Footer />
      </div>
    );
  }

}
