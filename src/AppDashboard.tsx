import React, { Component } from 'react';
import { Icon, Panel, Timeline } from 'rsuite';
import firebase from 'firebase';

// interface AppDashboardState {
//   notes: [];
// }

export default class AppDashboard extends Component<{
  app: firebase.app.App;
}> {
  componentDidMount() {
    if (!this.props.app.database) {
      return;
    }
    this.props.app
      .database()
      .ref('annotations')
      .once('value')
      .then((snapshot) => {
        console.log(snapshot.val());
      });
  }

  render() {
    return (
      <Panel>
        <Timeline className='custom-timeline'>
          <Timeline.Item dot={<Icon icon='credit-card' size='2x' />}>
            <p>March 1, 10:20</p>
            <p>Your order starts processing</p>
          </Timeline.Item>
          <Timeline.Item>
            <p>March 1, 11:34</p>
            <p>The package really waits for the company to pick up the goods</p>
          </Timeline.Item>
          <Timeline.Item>
            <p>March 1, 16:20</p>
            <p>[Packed]</p>
            <p>Beijing company has received the shipment</p>
          </Timeline.Item>
          <Timeline.Item dot={<Icon icon='plane' size='2x' />}>
            <p>March 2, 06:12</p>
            <p>[In transit]</p>
            <p>Order has been shipped from Beijing to Shanghai</p>
          </Timeline.Item>
          <Timeline.Item dot={<Icon icon='truck' size='2x' />}>
            <p>March 2, 09:20</p>
            <p>[In transit]</p>
            <p>
              Sended from the Shanghai Container Center to the distribution
              center
            </p>
          </Timeline.Item>
          <Timeline.Item dot={<Icon icon='user' size='2x' />}>
            <p>March 3, 14:20</p>
            <p>[Delivery]</p>
            <p>
              Shanghai Hongkou District Company Deliverer: Mr. Li, currently
              sending you a shipment
            </p>
          </Timeline.Item>
          <Timeline.Item
            dot={
              <Icon
                icon='check'
                size='2x'
                style={{ background: '#15b215', color: '#fff' }}
              />
            }
          >
            <p>March 3, 17:50</p>
            <p>[Received]]</p>
            <p>Your courier has arrived and the signer is the front desk</p>
          </Timeline.Item>
        </Timeline>
        {/* <IconButton icon={<Icon icon='camera' />} size={'lg'}>
          Find Note
        </IconButton> */}
      </Panel>
    );
  }
}
