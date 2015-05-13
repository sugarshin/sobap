import React from 'react';
import {Link} from 'react-router';

export default class Header extends React.Component {

  // static get propTypes() {
  //   return {
  //
  //   };
  // }

  // static get defaultProps() {
  //   return {
  //
  //   };
  // }

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <header className="g-header">
        <h1><a href="./">SOBAP</a></h1>
        <div className="g-menu">
          <ul>
            <li>
              <Link to="search">
                <span className="octicon octicon-search"></span>
                <span>Search</span>
              </Link>
            </li>
            <li>
              <Link to="star">
                <span className="octicon octicon-star"></span>
                <span>Star</span>
              </Link>
            </li>
          </ul>
        </div>
      </header>
    );
  }

}
