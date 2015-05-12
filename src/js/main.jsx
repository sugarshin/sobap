import React from 'react';
import { run, HashLocation } from 'react-router';

import routes from './config/routes';

run(routes, HashLocation, (Root) => {
  React.render(<Root />, document.getElementById('container'));
});
