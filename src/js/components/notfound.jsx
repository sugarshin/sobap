import React from 'react';
import { RouteHandler } from 'react-router';

export default class NotFound extends React.Component {

  // static get propTypes() { return {}; }
  //
  // static get defaultProps() { return {}; }

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="main not-found">
        <h2>404 Not Found <span className="mega-octicon octicon-megaphone"></span></h2>
        <p>Page Not Found...</p>
        <RouteHandler />
      </div>
    );
  }

}
