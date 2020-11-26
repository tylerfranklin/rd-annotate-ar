import React, { Component } from 'react';
// import AppSideBar from './AppSideBar';
// import AppBody from './AppBody';
import firebase from 'firebase';

export default class PageHome extends Component<{
  signOut: () => void;
  firebaseApp: firebase.app.App;
}> {
  render() {
    // const { signOut, firebaseApp } = this.props;
    return (
      <div>
        {/* <AppSideBar {...{ signOut }} />
        <AppBody {...{ signOut, firebaseApp }} /> */}
      </div>
    );
  }
}

// export default withStyles(styles)(PageHome);
