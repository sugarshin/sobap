import React from 'react';
import {RouteHandler} from 'react-router';

import Header from './partials/header';
import Footer from './partials/footer';

import actions from '../actions/actions';

export default class App extends React.Component {

  constructor(props) {
    super(props);
  }

  componentDidMount() {
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
