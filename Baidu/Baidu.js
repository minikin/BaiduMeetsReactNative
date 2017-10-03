import {
    requireNativeComponent,
    View,
    NativeModules,
    Platform,
    DeviceEventEmitter
  } from 'react-native';
  
  import React, { Component, PropTypes } from 'react';
  
  import _MapTypes from './MapTypes';
  import _MapView from './MapView';
  import _Geolocation from './Geolocation';
  
  export const MapTypes = _MapTypes;
  export const MapView = _MapView;
  export const Geolocation = _Geolocation;