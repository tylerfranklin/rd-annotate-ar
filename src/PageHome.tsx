import React, { Component } from 'react';
import AppDashboard from './AppDashboard';

export default class PageHome extends Component {
  render() {
    return (
      <div>
        {/* routing */}
        <AppDashboard {...this.props} />
      </div>
    );
  }
}

// export default withStyles(styles)(PageHome);
