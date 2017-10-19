import React, { Component } from 'react';
import { StyleSheet, View, NativeModules, Image } from 'react-native';
import { MapView, MapTypes, MapHelper } from './Baidu/Baidu';

const mapHelper = new MapHelper();

export default class BaiduMapDemo extends Component {
    
      constructor() {
        super();
  
        this.state = {
          mayType: MapTypes.SATELLITE,
          zoom: 10,
          center: {
            longitude: 113.981718,
            latitude: 22.542449
          },
          markers: [{
            longitude: 113.981718,
            latitude: 22.542449,
            title: "Window of the world"
          },{
            longitude: 113.995516,
            latitude: 22.537642,
            title: "world world world"
          }]
        };
      }

      componentWillMount() {
         mapHelper.setPinImageWith('/Users/mnkn/Desktop/WIP/MapDemo/BaiduMeetsReactNative/marker.png');
      }

      render() {
        return (
          <View style={styles.container}>
            <MapView 
              zoom={this.state.zoom}
              mapType={this.state.mapType}
              center={this.state.center}
              markers={this.state.markers}
              style={styles.map}
            >
            </MapView>
          </View>
        );
      }
    }
    
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'center'
  },
  map: {
    flex:1,
    width:'100%',
    height: '100%'
  }
});