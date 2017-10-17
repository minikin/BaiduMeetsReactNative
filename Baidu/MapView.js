import {
  requireNativeComponent,
  View,
  NativeModules,
  Platform,
  DeviceEventEmitter
} from 'react-native';
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import MapTypes from './MapTypes';

const BaiduMapView = requireNativeComponent('RCTBaiduMapView', MapView, {
  nativeOnly: {onChange: true}
});

export default class MapView extends Component {
  static propTypes = {
    ...View.propTypes,
    zoomControlsVisible: PropTypes.bool,
    mapType: PropTypes.number,
    zoom: PropTypes.number,
    center: PropTypes.object,
    markers: PropTypes.array,
    onMapStatusChange: PropTypes.func,
    onMapLoaded: PropTypes.func,
    onMarkerClick: PropTypes.func,
  };

  static defaultProps = {
    zoomControlsVisible: true,
    mapType: MapTypes.NORMAL,
    markers: [],
    center: null,
    zoom: 10
  };

  constructor() {
    super();
  }

  _onChange(event) {
    if (typeof this.props[event.nativeEvent.type] === 'function') {
      this.props[event.nativeEvent.type](event.nativeEvent.params);
    }
  }

  render() {
    return <BaiduMapView {...this.props} onChange={this._onChange.bind(this)}/>;
  }
}
