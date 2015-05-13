import React from 'react';
import {compileFile} from 'react-jade';

const template = compileFile(
  `${__dirname}/../../templates/shop-detail-body.jade`
);

export default class ShopDetailBody extends React.Component {

  static get propTypes() {
    return {
      data: React.PropTypes.object,
      onClickStar: React.PropTypes.func,
      isStarred: React.PropTypes.bool
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

  render() {
    return template(this.props);
  }

}
