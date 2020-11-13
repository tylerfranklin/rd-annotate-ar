// import logo from './logo.svg';
import './App.css';

import * as React from 'react';
import * as firebase from 'firebase/app';
import 'firebase/auth';

import withFirebaseAuth, { WrappedComponentProps } from 'react-with-firebase-auth';

import firebaseConfig from './firebaseConfig';

const firebaseApp = firebase.initializeApp(firebaseConfig);

const firebaseAppAuth = firebaseApp.auth();

/** See the signature above to find out the available providers */
const providers = {
  googleProvider: new firebase.auth.GoogleAuthProvider(),
};

/** providers can be customised as per the Firebase documentation on auth providers **/
providers.googleProvider.setCustomParameters({
  hd: 'mycompany.com',
});

/** Create the FirebaseAuth component wrapper */
const createComponentWithAuth = withFirebaseAuth({
  providers,
  firebaseAppAuth,
});

const App = ({
  /** These props are provided by withFirebaseAuth HOC */
  // signInWithEmailAndPassword,
  // createUserWithEmailAndPassword,
  signInWithGoogle,
  // signInWithFacebook,
  // signInWithGithub,
  // signInWithTwitter,
  // signInAnonymously,
  signOut,
  // setError,
  user,
  // error,
  loading,
}/*: WrappedComponentProps*/) => (
  <React.Fragment>
    {
      user
        ? <h1>Hello, {user.displayName}</h1>
        : <h1>Log in</h1>
    }

    {
      user
        ? <button onClick={signOut}>Sign out</button>
        : <button onClick={signInWithGoogle}>Sign in with Google</button>
    }

    {
      loading && <h2>Loading..</h2>
    }
  </React.Fragment>
);

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

/** Wrap it */
export default createComponentWithAuth(App);