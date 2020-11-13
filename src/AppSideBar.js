import logo from './logo.svg';
import { Component } from 'react';
import { Icon, Nav, Dropdown, Sidenav, Sidebar } from 'rsuite';
import NavToggle from './AppNavToggle';

const headerStyles = {
  padding: 18,
  fontSize: 16,
  height: 56,
  background: '#34c3ff',
  color: ' #fff',
  whiteSpace: 'nowrap',
  overflow: 'hidden',
};
export default class AppSideBar extends Component {
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
    const { expand } = this.state;
    return (
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
        <Sidenav expanded={expand} defaultOpenKeys={['3']} appearance='subtle'>
          <Sidenav.Body>
            <Nav>
              <Nav.Item eventKey='1' active icon={<Icon icon='dashboard' />}>
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
    );
  }
}
