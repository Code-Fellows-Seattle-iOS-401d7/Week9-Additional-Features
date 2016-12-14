//
//  CustomPFLoginViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "CustomPFLoginViewController.h"

@implementation CustomPFLoginViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.signUpController.signUpView.backgroundColor = [UIColor blueColor];
    
}


-(void)changeLogo {
    UIImage *kiddoLogo = [UIImage imageNamed:@"kiddo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:kiddoLogo];
    self.logInView.backgroundColor = [UIColor orangeColor];
    self.logInView.logo = imageView;
}
@end
