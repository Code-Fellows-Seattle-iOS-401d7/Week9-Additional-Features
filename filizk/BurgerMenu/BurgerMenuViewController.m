//
//  BurgerMenuViewController.m
//  BurgerMenu
//
//  Created by Filiz Kurban on 12/12/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "BurgerMenuViewController.h"


CGFloat kBurgerOpenScreenBoundary = 0.33; // value 0.0 - 1.0.
CGFloat kBurgerMenuWidth = 0.5; // value 0.0 - 1.0

CGFloat kBurgerImageWidth = 50.0;
CGFloat kBurgerImageHeight = 50.0;
CGFloat kBurgerImagePadding = 20.0;

NSTimeInterval kAnimationSlideMenuOpenTime = 0.25; // quarter of a second is good for now.
NSTimeInterval kAnimationSlideMenuCloseTime = 0.15;

@interface BurgerMenuViewController () <UITableViewDelegate>

@property(strong,nonatomic) NSArray *viewControllers;
@property(strong, nonatomic) UIViewController *topViewController;

@property(strong, nonatomic) UIButton *burgerButton;
@property(strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //we have a reference to the storyboard, so using storyboard to get the UIViewController.
    UIViewController *firstViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1"];
    UIViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController2"];

    self.viewControllers = @[firstViewController, secondViewController]; //This is the same thing as alloc, init with objects with these object. This is done with literals -> @
    self.topViewController = self.viewControllers.firstObject;

    UITableViewController *menuTableController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTable"];

    [self setupChildController:menuTableController];
    [self setupChildController:firstViewController];

    menuTableController.tableView.delegate = self;

    [self setupBurgerButton];
    [self setupPanGesture];


}

-(void)setupChildController:(UIViewController *)childViewController {
    [self addChildViewController:childViewController];

    childViewController.view.frame = self.view.frame;

    [self.view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
}


-(void)setupBurgerButton {
    //Structs have make in their call to make a struct. Like CGRectMake below.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kBurgerImagePadding, kBurgerImagePadding, kBurgerImageWidth, kBurgerImageHeight)];

    [button setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    [self.topViewController.view addSubview:button];

    [button addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.burgerButton = button;

}

-(void)setupPanGesture {
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(topViewControlerPanned:)];
    [self.topViewController.view addGestureRecognizer:self.panGesture];
}

//gesture regosnizers have states (like beginned, ended, etc)
-(void)topViewControlerPanned:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.topViewController.view];
    CGPoint translation = [sender translationInView:self.topViewController.view];

    NSLog(@"Velocity: %f", velocity.x);
    NSLog(@"Translation: %f", translation.x);

    if (sender.state == UIGestureRecognizerStateChanged) {
        if (translation.x >= 0) {
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.view.center.y);

            [sender setTranslation:CGPointZero inView:self.topViewController.view];
        }
    }

    __weak typeof(self) bruce = self;
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.topViewController.view.frame.origin.x > self.view.frame.size.width * kBurgerOpenScreenBoundary) {

            [UIView animateWithDuration: kAnimationSlideMenuOpenTime
                             animations:^{
                                 __strong typeof(bruce) hulk = bruce;
                                 hulk.topViewController.view.center = CGPointMake(hulk.view.center.x/kBurgerMenuWidth, hulk.view.center.y);
                             } completion:^(BOOL finished) {
                                 __strong typeof(bruce) hulk = bruce;
                                 UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc]initWithTarget:hulk action:@selector(tapToCloseMenu:)];
                                 [hulk.topViewController.view addGestureRecognizer:tapToClose];
                                 //hulk.burgerButton.userInteractionEnabled = NO;
                             }];
        } else {
            [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
                 __strong typeof(bruce) hulk = bruce;
                hulk.topViewController.view.center = hulk.view.center;
            } completion:^(BOOL finished) {

            }];
        }
    }
}

-(void)burgerButtonPressed:(UIButton *)sender {

    __weak typeof(self) bruce = self;

    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
        __strong typeof(bruce) hulk = bruce;
        hulk.topViewController.view.center = CGPointMake(hulk.view.center.x / kBurgerMenuWidth, hulk.view.center.y);

    } completion:^(BOOL finished) {
         __strong typeof(bruce) hulk = bruce;

        UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc]initWithTarget:hulk action:@selector(tapToCloseMenu:)];
        [hulk.topViewController.view addGestureRecognizer:tapToClose];

        sender.userInteractionEnabled = NO;
        //hulk.burgerButton.userInteractionEnabled = NO;
    }];
}

-(void)tapToCloseMenu:(UITapGestureRecognizer *)sender {
    [self.topViewController.view removeGestureRecognizer:sender];

    __weak typeof(self) bruce = self;

    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
         __strong typeof(bruce) hulk = bruce;
        hulk.topViewController.view.center = hulk.view.center;
    } completion:^(BOOL finished) {
         __strong typeof(bruce) hulk = bruce;
        hulk.burgerButton.userInteractionEnabled = YES;
    }];

}

//MARK: UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *newTop = self.viewControllers[indexPath.row];

    __weak typeof(self) bruce = self;
    [UIView animateWithDuration:kAnimationSlideMenuOpenTime animations:^{
         __strong typeof(bruce) hulk = bruce;
        hulk.topViewController.view.frame = CGRectMake(hulk.view.frame.size.width,
                                                       hulk.view.frame.origin.y,
                                                       hulk.view.frame.size.width,
                                                       hulk.view.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(bruce) hulk = bruce;

        CGRect oldFrame = hulk.topViewController.view.frame;
        [hulk.topViewController willMoveToParentViewController:nil];
        [hulk.topViewController.view removeFromSuperview];
        [hulk.topViewController removeFromParentViewController];

        [hulk setupChildController:newTop];

        newTop.view.frame = oldFrame;

        hulk.topViewController = newTop;

        [hulk.burgerButton removeFromSuperview];
        [hulk.topViewController.view addSubview:hulk.burgerButton];

        [UIView animateWithDuration:kAnimationSlideMenuCloseTime animations:^{
            hulk.topViewController.view.frame = hulk.view.frame ;

        } completion:^(BOOL finished) {
            [hulk.topViewController.view addGestureRecognizer:hulk.panGesture];
            hulk.burgerButton.userInteractionEnabled = YES;
        }];


    }];
}


@end
