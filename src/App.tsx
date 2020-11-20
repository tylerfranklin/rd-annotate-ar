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

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: 'AIzaSyCy10l3nMOQR7efvT7XpTUw8TLnuG5BmdA',
  authDomain: 'annotate-ar.firebaseapp.com',
  databaseURL: 'https://annotate-ar.firebaseio.com',
  projectId: 'annotate-ar',
  storageBucket: 'annotate-ar.appspot.com',
  messagingSenderId: '387518232919',
  appId: '1:387518232919:web:c0d994de12c8db3fff6612',
  measurementId: 'G-CYTHK2HS4F',
};

const firebaseApp = firebase.initializeApp(firebaseConfig);

/** See the signature above to find out the available providers */
const firebaseAppAuth = firebaseApp.auth();
const providers = {
  googleProvider: new firebase.auth.GoogleAuthProvider(),
};
class App extends Component<WrappedComponentProps> {
  render() {
    return (
      <Container className='App'>
        {this.props.user ? <AppSideBar {...this.props} /> : null}
        <AppBody {...this.props} />
      </Container>
    );
  }
}

export default withFirebaseAuth({
  providers,
  firebaseAppAuth,
})(App);
