//
//  BaseModule.h
//  RCTBaiduMap
//
//  Created by Sasha Prokhorenko on 03.10.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import "React/RCTEventDispatcher.h"
#import "React/RCTBridge.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface BaseModule : NSObject <RCTBridgeModule> {
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

-(void)sendEvent:(NSString *)name body:(NSMutableDictionary *)body;
-(NSMutableDictionary *)getEmptyBody;

@end

