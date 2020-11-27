import './App.css';
import 'rsuite/dist/styles/rsuite-dark.min.css';
import React, { Component } from 'react';
import withFirebaseAuth, {
  WrappedComponentProps,
} from 'react-with-firebase-auth';
import firebase from 'firebase/app';
import 'firebase/auth';
import { Container } from 'rsuite';
import AppSideBar from './AppSideBar';
import AppBody from './AppBody';

class App extends Component<WrappedComponentProps> {
  render() {
    return (
      <Container className='App'>
        <AppSideBar {...this.props} />
        <AppBody {...this.props} />
      </Container>
    );
  }
}

export default withFirebaseAuth({
  providers: {
    googleProvider: new firebase.auth.GoogleAuthProvider(),
  },
  firebaseAppAuth: firebase
    .initializeApp({
      apiKey: 'AIzaSyCy10l3nMOQR7efvT7XpTUw8TLnuG5BmdA',
      authDomain: 'annotate-ar.firebaseapp.com',
      databaseURL: 'https://annotate-ar.firebaseio.com',
      projectId: 'annotate-ar',
      storageBucket: 'annotate-ar.appspot.com',
      messagingSenderId: '387518232919',
      appId: '1:387518232919:web:c0d994de12c8db3fff6612',
      measurementId: 'G-F81VGS13K3',
    })
    .auth(),
})(App);
