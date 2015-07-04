import React from 'react';
import { run, HashLocation } from 'react-router';
import regeneratorRuntime from 'babel-runtime/regenerator';

import routes from './config/routes';

global.regeneratorRuntime = regeneratorRuntime;

run(routes, HashLocation, Root => {
  React.render(<Root />, document.getElementById('container'));
});
