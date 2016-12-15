//
//  AddStudentViewController.h
//  ClassRoster
//
//  Created by Filiz Kurban on 11/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)saveButtonPressed:(UIButton *)sender;

@end
