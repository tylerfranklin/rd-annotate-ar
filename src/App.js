import './App.css';
import 'rsuite/dist/styles/rsuite-dark.min.css';
import { Component } from 'react';
import withFirebaseAuth from 'react-with-firebase-auth';
import firebase from 'firebase/app';
import 'firebase/auth';
import firebaseConfig from './firebaseConfig';
import { Container } from 'rsuite';
import AppSideBar from './AppSideBar';
import AppBody from './AppBody';

const firebaseApp = firebase.initializeApp(firebaseConfig);

/** See the signature above to find out the available providers */
const firebaseAppAuth = firebaseApp.auth();
const providers = {
  googleProvider: new firebase.auth.GoogleAuthProvider(),
};
class App extends Component {
  render() {
    const { user, signOut, signInWithGoogle } = this.props;
    return (
      <Container className='App'>
        <AppSideBar />
        <AppBody {...{ user, signOut, signInWithGoogle }} />
      </Container>
    );
  }
}

export default withFirebaseAuth({
  providers,
  firebaseAppAuth,
})(App);
