import logo from './logo.svg';
import React, { Component } from 'react';
import { IconButton, Icon, Content, Panel } from 'rsuite';
import { WrappedComponentProps } from 'react-with-firebase-auth';
import AppDashboard from './AppDashboard';

export default class AppBody extends Component<WrappedComponentProps> {
  render() {
    const { user, signInWithGoogle } = this.props;
    return (
      <Content className='App-content'>
        {(user && <AppDashboard {...this.props} />) || (
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
