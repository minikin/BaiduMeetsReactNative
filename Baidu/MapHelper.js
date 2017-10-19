import { NativeModules, } from 'react-native';
import React, { Component } from 'react';
import PropTypes from 'prop-types';
const module = NativeModules.BaiduBridgeHelper;
  
export default class MapHelper {

    setPinImageWith(imagePath){
        module.setPinImageWith(imagePath)
    }

    setCustomMapStyle(){
        
    }

    setCustomMapWithJSON(stylePath) {

    }
}