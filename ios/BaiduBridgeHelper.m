//
//  BaiduBridgeHelper.m
//  BaiduMeetsReactNative
//
//  Created by Sasha Prokhorenko on 19.10.17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "BaiduBridgeHelper.h"
#import <React/RCTLog.h>
#import "Constants.h"

@implementation BaiduBridgeHelper

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setPinImageWith:(NSString *)imageName) {
  UIImage *image = [UIImage imageWithContentsOfFile: imageName];
  RCTLogInfo(@"IMAGE ======== %@", image.debugDescription);
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"pinImage"];
  [[NSNotificationCenter defaultCenter] postNotificationName:sendCustomPinImage object:self userInfo:userInfo];
}

@end
