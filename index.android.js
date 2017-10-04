import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
import BaiduMapDemo from './BaiduMapDemo';

export default class BaiduMeetsReactNative extends Component {
  render() {
    return (
      <BaiduMapDemo />
    );
  }
}

AppRegistry.registerComponent('BaiduMeetsReactNative', () => BaiduMeetsReactNative);
