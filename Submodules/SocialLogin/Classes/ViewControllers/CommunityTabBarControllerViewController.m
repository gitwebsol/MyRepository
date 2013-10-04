//
//  CommunityTabBarControllerViewController.m
//  suregift
//
//  Created by Matteo Gobbi on 27/02/13.
//  Copyright (c) 2013 Matteo Gobbi. All rights reserved.
//

#import "CommunityTabBarControllerViewController.h"
#import "SVProgressHUD.h"

@interface CommunityTabBarControllerViewController ()
    -(void)setModeLoading:(BOOL)active;
@end

@implementation CommunityTabBarControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self performSelectorInBackground:@selector(loading) withObject:nil];
        [Utility logout];

        [self setModeLoading:NO];
    }
    [super viewWillDisappear:animated];
}

-(void)loading {
    [self setModeLoading:YES];
}

-(void)setModeLoading:(BOOL)active {
//    if(active) {
//        if(loadView == nil) {
//            loadView = [[GBLoadingView alloc] initWithFrame:CGRectMake(320/2-160/2, (480-64)/2-125/2, 160, 125) opacity:1.0 message:@"Login.." cornerRadius:10.0 activityStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            loadView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
//        }
//        [self.view addSubview:loadView];
//        [self.view setUserInteractionEnabled:NO];
//    } else {
//        [loadView removeFromSuperview];
//        [self.view setUserInteractionEnabled:YES];
//    }
    
    if(active) {
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    } else {
        [SVProgressHUD dismiss];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
