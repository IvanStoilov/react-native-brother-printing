// main index.js

import { NativeModules } from 'react-native';

const { ReactNativeBrotherPrinting } = NativeModules || {};

export function printImageViaWifi(uri, ipAddress, modelName) {
  if (!uri) {
    return new Error('image uri missing');
  }

  if (!ipAddress) {
    return new Error('ip address missing');
  }

  if (!modelName) {
    return new Error('model name missing');
  }

  return new Promise((resolve, reject) => {
    return ReactNativeBrotherPrinting?.printImageViaWifi(
      uri,
      ipAddress,
      modelName,
      (error, message) => {
        if (error) {
          reject({ error, message });
        } else {
          resolve();
        }
      }
    );
  });
}

export function printImageViaBluetooth(uri, modelName) {
  if (!uri) {
    return new Error('image uri missing');
  }

  if (!modelName) {
    return new Error('modelName missing');
  }

  return new Promise((resolve, reject) => {
    return ReactNativeBrotherPrinting?.printImageViaBluetooth(
      uri,
      modelName,
      (error, message) => {
        if (error) {
          reject({ error, message });
        } else {
          resolve();
        }
      }
    );
  });
}
