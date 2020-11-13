import logo from './logo.svg';
import './App.css';
import 'rsuite/dist/styles/rsuite-default.css';
import {Component} from 'react';
import withFirebaseAuth from 'react-with-firebase-auth'
import firebase from 'firebase/app';
import 'firebase/auth';
import firebaseConfig from './firebaseConfig';
import { IconButton } from 'rsuite';

const firebaseApp = firebase.initializeApp(firebaseConfig);

/** See the signature above to find out the available providers */
const firebaseAppAuth = firebaseApp.auth();const providers = {
  googleProvider: new firebase.auth.GoogleAuthProvider(),
};

/** providers can be customised as per the Firebase documentation on auth providers **/
// providers.googleProvider.setCustomParameters({
//   hd: 'mycompany.com',
// });
// const App = ({
//   /** These props are provided by withFirebaseAuth HOC */
//   // signInWithEmailAndPassword,
//   // createUserWithEmailAndPassword,
//   signInWithGoogle,
//   // signInWithFacebook,
//   // signInWithGithub,
//   // signInWithTwitter,
//   // signInAnonymously,
//   signOut,
//   // setError,
//   user,
//   // error,
//   loading,
// }/*: WrappedComponentProps*/) => (
//   <React.Fragment>
//     {
//       user
//         ? <h1>Hello, {user.displayName}</h1>
//         : <h1>Log in</h1>
//     }

//     {
//       user
//         ? <button onClick={signOut}>Sign out</button>
//         : <button onClick={signInWithGoogle}>Sign in with Google</button>
//     }

//     {
//       loading && <h2>Loading..</h2>
//     }
//   </React.Fragment>
// );

class App extends Component {
  render() {
    const {
      user,
      signOut,
      signInWithGoogle,
    } = this.props;
    return (
      <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        {
          user
            ? <button onClick={signOut}>Sign out</button>
            : <IconButton appearance="primary" onClick={signInWithGoogle}>Sign in with Google</IconButton>
        }
      </header>
    </div>
    );
  }
}

export default withFirebaseAuth({
  providers,
  firebaseAppAuth,
})(App);
