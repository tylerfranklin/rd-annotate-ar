import React from 'react';
import { WrappedComponentProps } from 'react-with-firebase-auth';
import { Icon, Navbar, Nav, Dropdown } from 'rsuite';

interface NavToggleProps extends WrappedComponentProps {
  expand: boolean;
  onChange: () => void;
}

const iconStyles = {
  width: 56,
  height: 56,
  lineHeight: '56px',
  textAlign: 'center' as 'center',
};

const NavToggle = ({ expand, onChange, signOut }: NavToggleProps) => {
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
            <Dropdown.Item onClick={signOut}>Sign out</Dropdown.Item>
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

export default NavToggle;
