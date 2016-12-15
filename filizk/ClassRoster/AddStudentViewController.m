//
//  AddStudentViewController.m
//  ClassRoster
//
//  Created by Filiz Kurban on 11/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "AddStudentViewController.h"
#import "Student.h"
#import "StudentStore.h"

@interface AddStudentViewController ()

@end

@implementation AddStudentViewController

StudentStore *studentStore;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     studentStore = [StudentStore shared];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButtonPressed:(UIButton *)sender {
    //get all values.
    Student *newStudent = [[Student alloc]initWithFirstName:_name.text lastName:_lastName.text email:_email.text];

    [studentStore add:newStudent];

    [self dismissModalViewControllerAnimated:YES];
}
@end
