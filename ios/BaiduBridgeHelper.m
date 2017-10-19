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
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:pinImageKey];
  [[NSNotificationCenter defaultCenter] postNotificationName:sendCustomPinImage object:self userInfo:userInfo];
}

RCT_EXPORT_METHOD(setCustomMapStyleWith:(NSString *)JSONFile) {
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:JSONFile forKey:jsonFileKey];
  [[NSNotificationCenter defaultCenter] postNotificationName: customMapStyleWithJSON object:self userInfo: userInfo];
}

RCT_EXPORT_METHOD(customMapStyle:(BOOL)enable) {
  RCTLogInfo(@"======== JS NEWS ======== %d",enable);
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject: [NSNumber numberWithBool:enable]  forKey: customMapKey];
  [[NSNotificationCenter defaultCenter] postNotificationName: useCustomMapStyle object:self userInfo: userInfo];
}

@end
