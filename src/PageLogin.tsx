import { Component } from 'react';
import React from 'react';
import { Icon, IconButton, Panel } from 'rsuite';
import logo from './logo.svg';

export default class PageLogin extends Component<{
  signInWithGoogle: () => void;
}> {
  render() {
    return (
      <Panel>
        <img src={logo} className='App-logo' alt='logo' />
        <IconButton
          icon={<Icon icon='google' />}
          size={'lg'}
          appearance='primary'
          onClick={this.props.signInWithGoogle}
        >
          Sign in with Google
        </IconButton>
      </Panel>
    );
  }
}
