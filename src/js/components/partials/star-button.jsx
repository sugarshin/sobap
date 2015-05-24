import React from 'react';
import classnames from 'classnames';

import actions from '../../actions/actions';

export default class StarButton extends React.Component {

  static get propTypes() {
    return {
      id: React.PropTypes.string.isRequired,
      isStarred: React.PropTypes.bool.isRequired
    };
  }

  // static get defaultProps() {
  //   return {};
  // }

  constructor(props) {
    super(props);
  }

  _handleClickStar() {
    actions.updateStarredShop(this.props.id);
  }

  render() {
    let classes = classnames('star-button', {
      starred: this.props.isStarred
    });

    return (
      <button type="button"
              onClick={this._handleClickStar.bind(this)}
              className={classes}>
        <div className="star-button-inner">
          <span className="star-button-f left"></span>
          <span className="star-button-f right"></span>
          <span className="octicon octicon-star"></span>
        </div>
      </button>
    );
  }

}
