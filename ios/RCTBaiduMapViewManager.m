//
//  RCTBaiduMapViewManager.m
//  RCTBaiduMap
//
//  Created by Sasha Prokhorenko on 03.10.17.
//  Copyright © 2017 Sasha Prokhorenko. All rights reserved.
//

#import "RCTBaiduMapViewManager.h"
#import <UIKit/UIKit.h>
#import <React/RCTLog.h>
#import "Constants.h"

@implementation RCTBaiduMapViewManager;

UIImage *pinImage;
BOOL customMapStyle;

// MARK: - View properties

RCT_EXPORT_MODULE(RCTBaiduMapView)
RCT_EXPORT_VIEW_PROPERTY(mapType, int)
RCT_EXPORT_VIEW_PROPERTY(zoom, float)
RCT_EXPORT_VIEW_PROPERTY(markers, NSArray*)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(center, CLLocationCoordinate2D, RCTBaiduMapView) {
    [view setCenterCoordinate:json ? [RCTConvert CLLocationCoordinate2D: json] : defaultView.centerCoordinate];
}

// MARK: - View Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(receivedImageNotification:)
                                         name:sendCustomPinImage
                                         object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedCustomMapStyleNotification:)
                                                 name:useCustomMapStyle
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedCustomMapStyleJSONFileNotification:)
                                                 name:customMapStyleWithJSON
                                               object: nil];
    
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)view {
    RCTBaiduMapView *mapView = [RCTBaiduMapView new];
    mapView.delegate = self;
    [RCTBaiduMapView enableCustomMapStyle: customMapStyle];
    return mapView;
}

// MARK: - Notifacation mathods

-(void)receivedImageNotification:(NSNotification *) notification {
  NSDictionary *userInfo = notification.userInfo;
  UIImage *image = [userInfo valueForKey:pinImageKey];
  pinImage = image;
}

-(void)receivedCustomMapStyleJSONFileNotification:(NSNotification *) notification {
  NSDictionary *userInfo = notification.userInfo;
  NSString *path = [userInfo valueForKey:jsonFileKey];
  [RCTBaiduMapView customMapStyle: path];
}

-(void)receivedCustomMapStyleNotification:(NSNotification *) notification {
  NSDictionary *userInfo = notification.userInfo;
  NSNumber *enable = [userInfo valueForKey:customMapKey];
  customMapStyle = [enable boolValue];
}

// MARK: - BMKMapViewDelegate

-(void)mapViewDidFinishLoading:(RCTBaiduMapView *)mapView {
    NSDictionary* event = @{
                            @"type": @"onMapLoaded",
                            @"params": @{}
                            };

    [self sendEvent:mapView params:event];
}

-(void)mapStatusDidChanged: (RCTBaiduMapView *)mapView   {
  CLLocationCoordinate2D targetGeoPt = [mapView getMapStatus].targetGeoPt;
  NSDictionary* event = @{
                          @"type": @"onMapStatusChange",
                          @"params": @{
                              @"target": @{
                                  @"latitude": @(targetGeoPt.latitude),
                                  @"longitude": @(targetGeoPt.longitude)
                                  },
                              @"zoom": @"",
                              @"overlook": @""
                              }
                          };
  [self sendEvent: mapView params: event];
}

-(void)mapView:(RCTBaiduMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
  NSDictionary *event = @{
                          @"type": @"onMarkerClick",
                          @"params": @{
                              @"title": [[view annotation] title],
                              @"position": @{
                                  @"latitude": @([[view annotation] coordinate].latitude),
                                  @"longitude": @([[view annotation] coordinate].longitude)
                                  }
                              }
                          };
  [self sendEvent: mapView params: event];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass: [BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = pinImage;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}

// MARK: - Helpers

-(void)sendEvent:(RCTBaiduMapView *)mapView params:(NSDictionary *) params {
    if (!mapView.onChange) {
        return;
    }
    mapView.onChange(params);
}

@end
