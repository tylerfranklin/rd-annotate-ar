import logo from './logo.svg';
import './App.css';
import 'rsuite/dist/styles/rsuite-default.css';
import { Component } from 'react';
import withFirebaseAuth from 'react-with-firebase-auth';
import firebase from 'firebase/app';
import 'firebase/auth';
import firebaseConfig from './firebaseConfig';
import { IconButton, Icon } from 'rsuite';

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
      <div className='App'>
        <header className='App-header'>
          <img src={logo} className='App-logo' alt='logo' />
          {user ? (
            <button onClick={signOut}>Sign out</button>
          ) : (
            <IconButton
              icon={<Icon icon='google' />}
              size={'lg'}
              appearance='primary'
              onClick={signInWithGoogle}
            >
              Sign in with Google
            </IconButton>
          )}
        </header>
      </div>
    );
  }
}

export default withFirebaseAuth({
  providers,
  firebaseAppAuth,
})(App);
