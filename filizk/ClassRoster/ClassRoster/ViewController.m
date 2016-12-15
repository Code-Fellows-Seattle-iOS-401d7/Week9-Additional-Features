//
//  ViewController.m
//  ClassRoster
//
//  Created by Filiz Kurban on 11/16/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ViewController.h"
#import "StudentStore.h"
#import "ClassRoster-Swift.h"

//protocols live at the interface level
@interface ViewController ()<UITableViewDataSource>

//below is something that needs getter and setter. That's why it's not called @property. It's called a class variable
//{
//    Student *_currentStudent;
//}


    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) NSArray *allStudents;

@end

@implementation ViewController

StudentStore *ss;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.tableView setDataSource:self];

    ss = [StudentStore shared];

    Student *s = [[Student alloc] initWithFirstName:@"Adam" lastName:@"Wallraff" email:@"email.com"];

    [ss add: s];

    //CollegeStudent

}

-(void)viewWillAppear:(BOOL)animated {
    self.allStudents = [ss allStudents];
    self.tableView.reloadData;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allStudents.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.textLabel.text = [NSString stringWithFormat:@"Student: %@, %@, %@", [self.allStudents[indexPath.row]firstName],[self.allStudents[indexPath.row]lastName], [self.allStudents[indexPath.row]email]];

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
