//
//  ViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"
#import "Reminder.h"
#import "CustomPFLoginViewController.h"

//#import <FBSDKLoginKit/FBSDKLoginKit.h>

@import MapKit;
@import Parse;
@import ParseUI;

#import "MyQueue.h"
#import "MyStack.h"

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Creating a test object.
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//
//    testObject[@"foo"] = @"bar";
//
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *_Nullable error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//            return;
//        }
//
//        if (succeeded) {
//            NSLog(@"Successfully saved testObject");
//        }
//    }];

    Reminder *testReminder  = [Reminder object]; //Parse object needs to get created like this.
    testReminder.title = @"New Reminder! So Exciting!";

    [testReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error:%@", error.localizedDescription);
        }

        if (succeeded) {
            NSLog(@"Check your dashboard");
        }
    }];


    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"%@", objects);
            }];
        }
    }];


    self.mapView.delegate = self;
    LocationController.sharedController.delegate = self;



//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6580, -122.351096);
//    MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc]init];
//    newMapPoint.coordinate = coordinate;
//    newMapPoint.title = @"Barber Top24";
//    [self.locations addObject:newMapPoint];


    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    //[self.mapView setRegion:region animated:YES];

//    [self logIn];

    //[self requestPermissions];
    [self.mapView setShowsUserLocation:YES];

}
- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];

        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

        MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc]init];
        newMapPoint.coordinate = touchMapCoordinate;
        newMapPoint.title = @"New Location";

       [self.mapView addAnnotation:newMapPoint];

    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[[LocationController sharedController] manager] startUpdatingLocation]; //setting this makes the future calls to didUpdateLocation in the singletion

    [self getReminders];

   // CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.78583400, -122.40641700);
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    //[self.mapView setRegion:region animated:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderCreatedNotificationFired) name:@"ReminderCreated" object:nil];

}

-(void)reminderCreatedNotificationFired {
    NSLog(@"**Reminder was created! NSLog fired from %@", self);
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver: self name:@"ReminderCreated" object:nil];
}

//MARK: LocationContollerDelegate

-(void)locationControllerUpdatedLocation:(CLLocation *)location{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
    [self.mapView setRegion:region];
}

//MARK: MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;

    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }

    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.pinTintColor = [self generateRandomColor];

    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCalloutButton;

    return annotationView;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
         if ([sender isKindOfClass:[MKAnnotationView class]]) {
             MKAnnotationView *annotationView = (MKAnnotationView *)sender;
             DetailViewController *detailViewController = segue.destinationViewController;

             detailViewController.annotationTitle = annotationView.annotation.title;
             detailViewController.coordinate = annotationView.annotation.coordinate;

             __weak typeof(self) weakSelf = self;

             detailViewController.completion = ^(MKCircle *circle) {

                 __strong typeof(weakSelf) hulk = weakSelf;

                 [hulk.mapView removeAnnotation:annotationView.annotation];
                 [hulk.mapView addOverlay:circle]; //this will trigger rendererForOverlay method below.

             };

         }
    }
}

-(void)getReminders {
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];

     __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
         __strong typeof(weakSelf) hulk = weakSelf;
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                hulk.locations = objects; // these are reminders objects.

                for (Reminder *reminder in hulk.locations) {

                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude);
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                    annotation.coordinate = coordinate;
                    annotation.title = reminder.title;

                    [hulk.mapView addAnnotation:annotation];
                }

                NSLog(@"%@", objects);
            }];
        }
    }];



}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    renderer.fillColor = [UIColor blueColor];
    renderer.strokeColor = [UIColor redColor];
    renderer.alpha = 0.5;

    return renderer;
}


-(UIColor *)generateRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)logIn {
    if (![PFUser currentUser]) {
        CustomPFLoginViewController *loginViewController = [[CustomPFLoginViewController alloc]init];

        loginViewController.fields = PFLogInFieldsFacebook | PFLogInFieldsDefault;
        loginViewController.changeLogo;

        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self; //This is needed as we need to dismiss the UI and can't do that through the signupcontroller as we don't own the code.


        [self presentViewController:loginViewController animated:YES completion:nil];

    } else {
        [self setupAdditionalUI];
    }
}

-(void)setupAdditionalUI {
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOutPressed)];

    self.navigationItem.leftBarButtonItem = signOutButton;
}

//MARK: Parse Delegate Methods
-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI]; //Add the signOut button now. setupAdditionaUI is implementation above
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI]; //Add the signOut button now. setupAdditionaUI is implementation above
}

-(void)signOutPressed {
    [PFUser logOut];
    [self logIn];
}

-(void)testQueue {
    MyQueue *myQ = [[MyQueue alloc]init];
    [myQ enqueue:@"1"];
    [myQ enqueue:@"2"];
    [myQ enqueue:@"3"];

    NSLog(@"**Last item before dequeue = %@", myQ.peek);
    NSString *dequedNum = [myQ dequeue];
    NSLog(@"**Dequed Number=  %@",dequedNum);
    NSLog(@"**Last number after dequeue = %@",myQ.peek);
    [myQ enqueue:@"4"];
    NSLog(@"**Last number after dequeue = %@",myQ.peek); 

    //See location_remindersTests for more tests
}

-(void)testStack {
    MyStack *myS = [[MyStack alloc]init];
    [myS push:@"1"];
    [myS push:@"2"];
    [myS push:@"3"];

    NSLog(@"**Last item before popping = %@", myS.peek);
    NSString *poppedNum = [myS pop];
    NSLog(@"**Popped Number=  %@",poppedNum);
    NSLog(@"**Last number after pop = %@",myS.peek);
    [myS push:@"4"];
    NSLog(@"**Last number after pop = %@",myS.peek); //

    //See location_remindersTests for more tests

}

//Only needed when local LocationManager was being used.
//-(void)requestPermissions {
//    [self setLocationManager:[[CLLocationManager alloc]init]];
//
//    [self.locationManager requestWhenInUseAuthorization];
//
//}
////Coordinates for Denmark: 55.676098, 12.568337
//- (IBAction)setLocationToDenmark:(id)sender {
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(55.676098, 12.568337);
//
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
//
//    [self.mapView setRegion:region animated:YES];
//
//}
//
//- (IBAction)setLocationToAfrica:(id)sender {
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
//
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2000000, 2000000);
//
//    [self.mapView setRegion:region animated:YES];
//}
//
////41.015137	28.979530
//- (IBAction)setLocationToTurkey:(id)sender {
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(41.015137, 28.979530);
//
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
//
//    [self.mapView setRegion:region animated:YES];
//
//}
//
//- (IBAction)setLocationPressed:(id)sender {
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566, -122.351096);
//
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
//
//    [self.mapView setRegion:region animated:YES];
//
//}




@end
