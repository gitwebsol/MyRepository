//
//  MyViewController.m
//  suregift
//
//  Created by Matteo Gobbi on 31/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import "MyViewController.h"
#import "UserTableViewCell.h"
#import "DataManager.h"
#import "UserManager.h"
#import "SVProgressHUD.h"
#import "UserInfo.h"
#import "GenericWebViewController.h"
#import "MyDetailViewController.h"
#import "Constants.h"

//=======================================================================
// MyViewController - Private Interface
//=======================================================================
@interface MyViewController ()

@property (nonatomic, strong) NSMutableArray *infoArray;

@end

//=======================================================================
// UserManager - Implementation
//=======================================================================

@implementation MyViewController

//-----------------------------------------------------------------------
// Initialization
//-----------------------------------------------------------------------
#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    
    _infoArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(reloadUserInformation)
												 name:@"UserInformationChanged"
											   object:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    [self retrieveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.userTableView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setPointsLabel:nil];
    [super viewDidUnload];
}

//-----------------------------------------------------------------------
// UITableViewDataSource methods
//-----------------------------------------------------------------------
#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCustomCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    [cell updateWithInformation:[self.infoArray objectAtIndex:indexPath.row]];
    
    return cell;
}

//-----------------------------------------------------------------------
// UITableViewDelegate methods
//-----------------------------------------------------------------------
#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 25.0)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, tableView.frame.size.width, 25.0)];
    
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"EVENT"];
    [label setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label];
    [view setBackgroundColor:APP_COLOR_PINK];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    GenericWebViewController *controller = [[GenericWebViewController alloc] initWithNibName:@"WebView" bundle:nil];
//    [controller setURLstring:@"http://lparty.jp/explain"];
//    [self.navigationController pushViewController:controller animated:YES];
    
    UserInfo *user = [self.infoArray objectAtIndex:indexPath.row];
    NSLog(@"%@ %@ %@ %@", user.title, user.points, user.deadline, user.imageURL);
    
    MyDetailViewController *controller = [[MyDetailViewController alloc] initWithNibName:@"MyDetailViewController" bundle:nil];
    controller.userInfo = user;
    [self.navigationController pushViewController:controller animated:YES];
    
}

//-----------------------------------------------------------------------
// Custom methods
//-----------------------------------------------------------------------
#pragma mark - Custom methods
- (void)reloadUserInformation {
//    _profileImageView.image = [UIImage imageWithData:[Utility decryptStringToData:[Utility getDefaultValueForKey:USER_IMG_PROFILE]]];
}

//=======================================================================
// Data Handlers
//=======================================================================
#pragma mark - Data Handlers
- (void)retrieveData {
    [self.userTableView setHidden:YES];
    [self.pointsLabel setHidden:YES];
    
    [self.infoArray removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userId     = [[UserManager sharedInstance] userId];
    NSString *userToken  = [[UserManager sharedInstance] userToken];
    
    [params setObject:userId forKey:@"id"];
    [params setObject:userToken forKey:@"token"];
    
    [[DataManager sharedInstance] postRequestWithParameters:params
                                                     atPath:@"users/thirdtab"
                                                    inBlock:^(id results){
                                                        
                                                        [self.userTableView setHidden:NO];
                                                        [self.pointsLabel setHidden:NO];
                                                        
                                                        if ([results respondsToSelector:@selector(objectForKey:)]) {
                                                            NSString *points = [results objectForKey:@"points"];
                                                            [self.pointsLabel setText:[NSString stringWithFormat:@"%@", points]];
                                                            
                                                            NSArray *contents = [results objectForKey:@"root"];
                                                            for (NSDictionary *info in contents) {
                                                                UserInfo *infoU = [[UserInfo alloc] initWithInfo:[info objectForKey:@"Stamp"]];
                                                                infoU.points = points;
                                                                [self.infoArray addObject:infoU];
                                                                
                                                            }
                                                            
                                                            //Dispaly results and refresh tableview
                                                            [_userTableView reloadData];
                                                        }
                                                        
                                                        [SVProgressHUD dismiss];
                                                    }];
}

@end
