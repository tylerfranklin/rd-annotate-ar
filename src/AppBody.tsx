import logo from './logo.svg';
import React, { Component } from 'react';
import { IconButton, Icon, Content, Panel } from 'rsuite';
import { WrappedComponentProps } from 'react-with-firebase-auth';
import firebase from 'firebase';
import AppDashboard from './AppDashboard';

export interface AppBodyProps extends WrappedComponentProps {
  app: firebase.app.App;
}

export default class AppBody extends Component<AppBodyProps> {
  render() {
    const { user, signInWithGoogle, app } = this.props;
    return (
      <Content className='App-content'>
        {(user && <AppDashboard app={app} />) || (
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
