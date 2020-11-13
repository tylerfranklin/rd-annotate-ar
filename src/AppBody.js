import logo from './logo.svg';
import { Component } from 'react';
import { IconButton, Icon, Content, Panel } from 'rsuite';

export default class AppBody extends Component {
  render() {
    const { user, signOut, signInWithGoogle } = this.props;
    return (
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
    );
  }
}
