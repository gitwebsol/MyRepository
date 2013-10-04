//
//  MasterViewController.h
//  suregift
//
//  Created by Matteo Gobbi on 19/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParser.h"
#import "FriendsViewController.h"
#import "MyViewController.h"
#import "JoinViewController.h"
#import "SignUpViewController.h"
#import "ChooseProfileImageViewController.h"
#import "CommunityTabBarControllerViewController.h"

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ThreadCallBack, UIAlertViewDelegate> {
    RequestParser *loginParser;
    GBLoadingView *loadView;
    UIBarButtonItem *btLogin;
    
    FriendsViewController *friendsViewController;
    MyViewController *myViewController;
    CommunityTabBarControllerViewController *communityTabBarController;
    
    ChooseProfileImageViewController *chooseProfileImageViewController;
}

@property (nonatomic, retain) IBOutlet UITableView *tb;

@property (nonatomic, retain) IBOutlet UIButton *btJoin;
@property (nonatomic, retain) IBOutlet UIButton *btJoinFB;
@property (retain, nonatomic) IBOutlet UIButton *btSignIn;

//@property (nonatomic, retain) JoinViewController *joinViewC;

-(IBAction)login:(id)sender;
-(IBAction)join:(id)sender;
-(IBAction)joinFB:(id)sender;

-(void)loginWithSendConfirm:(BOOL)send;

-(void) notifyThreadEnd:(NSDictionary *)responseDict;

-(void)setModeLoading:(BOOL)active;

//-(void)goToCommunity;

-(void)getUserDetails;

@end
