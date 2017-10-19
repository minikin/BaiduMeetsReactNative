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

@implementation RCTBaiduMapViewManager;

UIImage *pinImage;
RCT_EXPORT_MODULE(RCTBaiduMapView)
RCT_EXPORT_VIEW_PROPERTY(mapType, int)
RCT_EXPORT_VIEW_PROPERTY(zoom, float)
RCT_EXPORT_VIEW_PROPERTY(markers, NSArray*)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(center, CLLocationCoordinate2D, RCTBaiduMapView) {
    [view setCenterCoordinate:json ? [RCTConvert CLLocationCoordinate2D: json] : defaultView.centerCoordinate];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(receivedImageNotification:)
                                         name:@"ImageData.From.JS"
                                         object: nil];
  }
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)view {
    [self setMapStyleWithJson];
    RCTBaiduMapView *mapView = [RCTBaiduMapView new];
    mapView.delegate = self;
    [RCTBaiduMapView enableCustomMapStyle:true];
    return mapView;
}

-(void)receivedImageNotification:(NSNotification *) notification {
  NSDictionary *userInfo = notification.userInfo;
  UIImage *image = [userInfo valueForKey:@"pinImage"];
  pinImage = image;
  RCTLogInfo(@"receiveTestNotification 1==1=12-=11=-21=- %@", image.description);
}

-(void)setMapStyleWithJson {
  NSString* path = [[NSBundle mainBundle] pathForResource:@"MidnightBlueStyle" ofType:@"json"];
  NSLog(@"MidnightBlueStyle %@", path);
  [RCTBaiduMapView customMapStyle: path];
}


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
        [self setPinWithImage: newAnnotationView];
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}

-(void)setPinWithImage:(BMKPinAnnotationView *)ann {
  ann.image = pinImage;
}

-(void)sendEvent:(RCTBaiduMapView *)mapView params:(NSDictionary *) params {
    if (!mapView.onChange) {
        return;
    }
    mapView.onChange(params);
}

@end
