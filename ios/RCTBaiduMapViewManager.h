//
//  RCTBaiduMapViewManager.h
//  RCTBaiduMap
//
//  Created by Sasha Prokhorenko on 03.10.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

#import "RCTBaiduMapView.h"

@interface RCTBaiduMapViewManager: RCTViewManager <BMKMapViewDelegate>
-(void)sendEvent:(RCTBaiduMapView *) mapView params:(NSDictionary *) params;
@end

