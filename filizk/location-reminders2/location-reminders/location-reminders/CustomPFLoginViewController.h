//
//  CustomPFLoginViewController.h
//  location-reminders
//
//  Created by Filiz Kurban on 12/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ParseUI;

@interface CustomPFLoginViewController : PFLogInViewController
//@property (readwrite, strong, nonatomic, nullable) UIView *logo;
//@property (readonly, strong, nonatomic, nullable) PFLogInView *logInView;

-(void)changeLogo;
@end
