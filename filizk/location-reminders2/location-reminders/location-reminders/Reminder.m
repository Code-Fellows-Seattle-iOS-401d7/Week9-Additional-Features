//
//  Reminder.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic title;
@dynamic radius;
@dynamic location;
@dynamic priority;

+(NSString *)parseClassName {
    return @"Reminder"; //This is the class name
}

+(void)load{
    [self registerSubclass];
}

@end
