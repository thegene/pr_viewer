import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import App from '../src/app';

describe('When I render the App', () => {
  let app;

  beforeEach(() => {
    app = shallow(<App />);
  });

  it('has three elements because why not?', () => {
    expect(app.find('li')).to.have.length(3);
  });
});
