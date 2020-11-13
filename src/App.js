import logo from './logo.svg';
import './App.css';
import 'rsuite/dist/styles/rsuite-dark.min.css';
import { Component } from 'react';
import withFirebaseAuth from 'react-with-firebase-auth';
import firebase from 'firebase/app';
import 'firebase/auth';
import firebaseConfig from './firebaseConfig';
import {
  IconButton,
  Icon,
  // Header,
  Navbar,
  Content,
  Container,
  FlexboxGrid,
  Panel,
  // Footer,
  Nav,
  Dropdown,
  Sidenav,
  Sidebar,
  // Form,
  // FormGroup,
} from 'rsuite';

const firebaseApp = firebase.initializeApp(firebaseConfig);

/** See the signature above to find out the available providers */
const firebaseAppAuth = firebaseApp.auth();
const providers = {
  googleProvider: new firebase.auth.GoogleAuthProvider(),
};

const headerStyles = {
  padding: 18,
  fontSize: 16,
  height: 56,
  background: '#34c3ff',
  color: ' #fff',
  whiteSpace: 'nowrap',
  overflow: 'hidden',
};

const iconStyles = {
  width: 56,
  height: 56,
  lineHeight: '56px',
  textAlign: 'center',
};

const NavToggle = ({ expand, onChange }) => {
  return (
    <Navbar
      appearance='subtle'
      className='nav-toggle'
      style={{ flex: 1, display: 'flex', flexFlow: 'column-reverse' }}
    >
      <Navbar.Body>
        <Nav>
          <Dropdown
            placement='topStart'
            trigger='click'
            renderTitle={(children) => {
              return <Icon style={iconStyles} icon='cog' />;
            }}
          >
            <Dropdown.Item>Help</Dropdown.Item>
            <Dropdown.Item>Settings</Dropdown.Item>
            <Dropdown.Item>Sign out</Dropdown.Item>
          </Dropdown>
        </Nav>

        <Nav pullRight>
          <Nav.Item
            onClick={onChange}
            style={{ width: 56, textAlign: 'center' }}
          >
            <Icon icon={expand ? 'angle-left' : 'angle-right'} />
          </Nav.Item>
        </Nav>
      </Navbar.Body>
    </Navbar>
  );
};

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      expand: false,
    };
    this.handleToggle = this.handleToggle.bind(this);
  }
  handleToggle() {
    this.setState({
      expand: !this.state.expand,
    });
  }
  render() {
    const { user, signOut, signInWithGoogle } = this.props;
    const { expand } = this.state;
    return (
      <div className='App'>
        <Container>
          <Sidebar
            style={{
              display: 'flex',
              flexDirection: 'column',
              background: '#000',
            }}
            width={expand ? 260 : 56}
            collapsible
          >
            <Sidenav.Header>
              <div style={headerStyles} title='Home'>
                <img src={logo} className='header-logo' alt='logo' />
                <span style={{ marginLeft: 12 }}>AR Notes</span>
              </div>
            </Sidenav.Header>
            <Sidenav
              expanded={expand}
              defaultOpenKeys={['3']}
              appearance='subtle'
            >
              <Sidenav.Body>
                <Nav>
                  <Nav.Item
                    eventKey='1'
                    active
                    icon={<Icon icon='dashboard' />}
                  >
                    Student View
                  </Nav.Item>
                  <Nav.Item eventKey='2' icon={<Icon icon='group' />}>
                    Student Analytics
                  </Nav.Item>
                  <Dropdown
                    eventKey='3'
                    trigger='hover'
                    title='Notes'
                    icon={<Icon icon='magic' />}
                    placement='rightStart'
                  >
                    <Dropdown.Item eventKey='3-1'>Add</Dropdown.Item>
                    <Dropdown.Item eventKey='3-2'>Manage</Dropdown.Item>
                    <Dropdown.Item eventKey='3-3'>Test</Dropdown.Item>
                  </Dropdown>
                  <Dropdown
                    eventKey='4'
                    trigger='hover'
                    title='Settings'
                    icon={<Icon icon='gear-circle' />}
                    placement='rightStart'
                  >
                    <Dropdown.Item eventKey='4-1'>Profile</Dropdown.Item>
                    <Dropdown.Item eventKey='4-2'>Account</Dropdown.Item>
                    <Dropdown.Item eventKey='4-3'>Accessibility</Dropdown.Item>
                    <Dropdown.Item eventKey='4-4'>Support</Dropdown.Item>
                    <Dropdown.Item eventKey='4-5'>About</Dropdown.Item>
                  </Dropdown>
                </Nav>
              </Sidenav.Body>
            </Sidenav>
            <NavToggle expand={expand} onChange={this.handleToggle} />
          </Sidebar>

          <Content className='App-content'>
            {(user && <button onClick={signOut}>Sign out</button>) || (
              <Panel>
                <img src={logo} className='App-logo' alt='logo' />
                <IconButton
                  icon={<Icon icon='google' />}
                  size={'lg'}
                  appearance='primary'
                  onClick={signInWithGoogle}
                >
                  Sign in with Google
                </IconButton>
              </Panel>
            )}
          </Content>
        </Container>
      </div>
    );
  }
}

export default withFirebaseAuth({
  providers,
  firebaseAppAuth,
})(App);
