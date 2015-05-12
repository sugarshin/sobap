import Promise from 'bluebird';

export default (namespace, payload) => {
  return new Promise((resolve) => {
    if (payload) {
      resolve(localStorage.setItem(namespace, JSON.stringify(payload)));
    }
    let data = localStorage.getItem(namespace);
    resolve( ((data !== 'undefined') && JSON.parse(data)) || [] );
  });
}
