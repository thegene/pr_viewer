import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import App from '../src/app';

describe('app', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = shallow(<App />);
  });

  it('says Hullo to Whorl', () => {
    expect(wrapper.text()).to.equal('Hullo Whorl');
  });
});
