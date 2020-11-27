import React, { Component } from 'react';
import { Content } from 'rsuite';
import firebase from 'firebase';
import PageHome from './PageHome';
import PageLogin from './PageLogin';

export interface AppBodyProps {
  signInWithGoogle: () => void;
  user?: firebase.User | null | undefined;
}

export default class AppBody extends Component<AppBodyProps> {
  render() {
    const { user, signInWithGoogle } = this.props;
    return (
      <Content className='App-content' style={{ overflow: 'auto' }}>
        {(user && <PageHome {...{ signInWithGoogle }} />) || (
          <PageLogin {...this.props} />
        )}
      </Content>
    );
  }
}
