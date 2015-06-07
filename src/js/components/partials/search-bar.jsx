import React from 'react';
import classnames from 'classnames';

import actions from '../../actions/actions';

export default class SearchBar extends React.Component {

  static get propTypes() {
    return {
      isResultsByGeolocation: React.PropTypes.bool
    };
  }

  static get defaultProps() {
    return {
      isResultsByGeolocation: false
    };
  }

  constructor(props) {
    super(props);

    // this.state = {
    //   nowGeolocationLodaing: false
    // };
  }

  _handleClickLocation() {
    // this.state = {
    //   nowGeolocationLodaing: true
    // };
    actions.searchShopByLocation();
  }

  _handleClickSearchKeyword() {
    let val = React.findDOMNode(this.refs.inputSearch).value;
    if (!val) {
      return;
    }
    actions.searchShopByKeyword(val);
  }

  // componentWillReceiveProps(/* nextProps */) {
  //   this.state = {
  //     nowGeolocationLodaing: false
  //   };
  // }

  render() {
    const { isResultsByGeolocation } = this.props;
    // const { nowGeolocationLodaing } = this.state;

    return (
      <div className="search-bar-container">
        <div className="search-bar">
          <div
            className={classnames(
              'search-near-button',
              {'is-active': isResultsByGeolocation}
            )}
          >
            <span
              className={classnames(
                'mega-octicon',
                'octicon-location'//,
                // {'geo-loading': nowGeolocationLodaing}
              )}
              onClick={this._handleClickLocation.bind(this)}
            ></span>
          </div>
          <div className="search-keyword-container">
            <input type="search" ref="inputSearch" />
            <div className="search-keyword-button">
              <button
                type="button"
                onClick={this._handleClickSearchKeyword.bind(this)}>
                <span className="octicon octicon-search"></span>
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

}
