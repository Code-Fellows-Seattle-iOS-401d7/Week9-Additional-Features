//
//  LocationController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/6/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "LocationController.h"


@interface LocationManager <CLLocationManagerDelegate>

@end

@implementation LocationController

+(instancetype)sharedController {
    static LocationController *sharedController;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[LocationController alloc]init];
    });

    return sharedController;
}

-(instancetype)init {
    self = [super self];
//don't call a getter/setter in a initialier, instead use _property. That's what we're doing in below initializer. _manager.delegate = self and not self.manager.delegate = self.
    if (self) {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;

        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 100;

        [_manager requestAlwaysAuthorization];

    }
    return self;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //NSLog(@"**locaiton %@", locations.lastObject.coordinate);
    [self.delegate locationControllerUpdatedLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
    NSLog(@"**locaiton %@", self.location);
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(nonnull CLRegion *)region {
    NSLog(@"**Started Monitoring Region for:%@", region);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region {
    NSLog(@"**USER DID ENTER REGION", region);
}

@end
