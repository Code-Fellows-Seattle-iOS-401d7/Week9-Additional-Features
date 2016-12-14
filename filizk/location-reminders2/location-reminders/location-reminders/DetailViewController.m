//
//  DetailViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/6/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"
#import <UserNotifications/UserNotifications.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *reminderTitle;
@property (weak, nonatomic) IBOutlet UITextField *radius;
@property (weak, nonatomic) IBOutlet UITextField *priority;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"**Annotation With Title:%@ - Lat:%.2f, Long:%.2f",
          self.annotationTitle,
          self.coordinate.latitude,
          self.coordinate.longitude);

   // self.reminderTitle.delegate = self;
    
}
- (IBAction)createReminder:(id)sender {
    NSString *reminderTitle = self.reminderTitle.text;
    NSNumber *radius = [NSNumber numberWithInteger:([self.radius.text floatValue])];

    Reminder *newReminder = [Reminder object];
    newReminder.title = reminderTitle;
    newReminder.radius = radius;
    newReminder.priority = self.priority.text;

    PFGeoPoint *reminderPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];

    newReminder.location = reminderPoint;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderCreated" object:nil];

    __weak typeof(self) bruce = self;

    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {

        __strong typeof(bruce)hulk = bruce;

        if(error) {
            NSLog(@"Error saving the reminder.", error.localizedDescription);
        } else {
            NSLog(@"Success: %i", succeeded);

            if (hulk.completion) {

                if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:hulk.coordinate radius:radius.floatValue identifier:reminderTitle];

                    [[LocationController sharedController].manager startMonitoringForRegion:region];

                    [hulk createNotificationForRegion:region withName:reminderTitle];
                }

                MKCircle *newCircle = [MKCircle circleWithCenterCoordinate:hulk.coordinate radius:radius.floatValue];
                hulk.completion(newCircle);

                [hulk.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

//we need content and trigger for every notification. Then the request gets these two, take the request to the notification center to show the notification to user.
-(void)createNotificationForRegion:(CLRegion *)region withName:(NSString *)reminderName {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];

    content.title = @"Location Reminder";
    content.body = reminderName;
    content.sound = [UNNotificationSound defaultSound];

  //  UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.7 repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:reminderName content:content trigger:trigger];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Adding Notification With Error", error.localizedDescription);
        }
    }];
}



@end
