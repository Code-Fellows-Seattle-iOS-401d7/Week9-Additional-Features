//
//  LocationController.h
//  location-reminders
//
//  Created by Filiz Kurban on 12/6/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol LocationControllerDelegate <NSObject>
@required
-(void)locationControllerUpdatedLocation:(CLLocation *)location;
@end


@interface LocationController : NSObject

@property(strong, nonatomic) CLLocationManager *manager;
@property(strong, nonatomic) CLLocation *location;

@property(weak, nonatomic) id<LocationControllerDelegate> delegate;


+(instancetype)sharedController;


@end
