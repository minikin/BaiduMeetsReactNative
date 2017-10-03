//
//  GoelocationModule.h
//  RCTBaiduMap
//
//  Created by Sasha Prokhorenko on 03.10.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

#import "BaseModule.h"
#import "RCTBaiduMapViewManager.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>


@interface GeolocationModule : BaseModule <BMKGeoCodeSearchDelegate> {
}

@end
