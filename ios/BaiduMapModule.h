//
//  BaiduMapModule.h
//  RCTBaiduMap
//
//  Created by Sasha Prokhorenko on 03.10.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

#import "BaseModule.h"
#import "RCTBaiduMapViewManager.h"

@interface BaiduMapModule : BaseModule <BMKMapViewDelegate>

-(BMKGeoCodeSearch *)getGeocodesearch;
-(void)sendEvent:(NSString *)name body:(NSMutableDictionary *)body;
-(NSMutableDictionary *)getEmptyBody;
-(CLLocationCoordinate2D)getBaiduCoor:(double)lat lng:(double)lng;
-(RCTBaiduMapView *) getBaiduMapView;

@end

