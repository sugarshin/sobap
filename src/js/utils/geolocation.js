import Promise from 'bluebird';

const TIMEOUT = 30000;

export default function geolocation(timeout) {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(
      pos => { resolve(pos); },
      err => { reject(err); },
      { timeout: timeout || TIMEOUT }
    );
  });
}
