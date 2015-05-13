import React from 'react';
import {compileFile} from 'react-jade';

const template = compileFile(`${__dirname}/../../templates/search-bar.jade`);

export default class SearchBar extends React.Component {

  static get propTypes() {
    return {
      onClickLocation: React.PropTypes.func,
      onClickSearchKeyword: React.PropTypes.func
    };
  }

  // static get defaultProps() {
  //   return {
  //
  //   };
  // }

  constructor(props) {
    super(props);
  }

  _onClickLocation() {
    this.props.onClickLocation();
  }

  _onClickSearchKeyword() {
    let v;
    if (!(v = React.findDOMNode(this.refs.inputSearch).value)) {
      return;
    }
    this.props.onClickSearchKeyword(v);
  }

  render() {
    return template({
      onClickLocation: this._onClickLocation.bind(this),
      onClickSearchKeyword: this._onClickSearchKeyword.bind(this)
    });
  }

}
