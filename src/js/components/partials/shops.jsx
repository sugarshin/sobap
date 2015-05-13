import React from 'react';
import includes from 'lodash.includes';

import Shop from './shop';

export default class Shops extends React.Component {

  static get propTypes() {
    return {
      classNames: React.PropTypes.string,
      shops: React.PropTypes.array,
      onClickStar: React.PropTypes.func,
      starredIDs: React.PropTypes.array
    };
  }

  static get defaultProps() {
    return {
      shops: []
    };
  }

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className={this.props.classNames}>
        {this.props.shops.map(shop => {
          return (
            <Shop
              key={shop.id}
              data={shop}
              onClickStar={this.props.onClickStar}
              isStarred={includes(this.props.starredIDs, shop.id)}
            />
          );
        })}
      </div>
    );
  }

}
