//
//  Reminder.h
//  location-reminders
//
//  Created by Filiz Kurban on 12/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property(strong,nonatomic) NSString *title;
@property(strong, nonatomic) NSNumber *radius;
@property(strong, nonatomic) PFGeoPoint *location;
@property(strong, nonatomic) NSString *priority;

@end
