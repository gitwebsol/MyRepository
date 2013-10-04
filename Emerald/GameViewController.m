//
//  GameViewController.m
//  Emerald
//
//  Created by Razvan on 6/27/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GameViewController.h"
#import "DataManager.h"
#import "UserManager.h"
#import "Event.h"
#import "EventTableViewCell.h"
#import "SVProgressHUD.h"
#import "GameScreenViewController.h"

//=======================================================================
// GameViewController - Private Interface
//=======================================================================
@interface GameViewController ()

@property (nonatomic, strong) NSMutableArray *infoArray;

@end

//=======================================================================
// GameViewController - Implementation
//=======================================================================
@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _infoArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadGame];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadGame];
//    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableV:nil];
    [self setPopupContainer:nil];
    [self setPopopView:nil];
    [self setPopupTextField:nil];

    [self setPopupCancelBtn:nil];
    [self setPopupSaveBtn:nil];
    [super viewDidUnload];
}

- (void)loadGame {
    NSURL *url = [[NSURL alloc] initWithString:MAIN_GAME_URL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:urlRequest];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

//=======================================================================
// UITableViewDataSource methods
//=======================================================================
#pragma mark - UITableViewDataSource methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCustomCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    [cell updateWithInformation:[self.infoArray objectAtIndex:indexPath.row]];
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

//=======================================================================
// UITableViewDelegate methods
//=======================================================================
#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Matikon"
                                                    message:@"Is it ok to consume your points?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 25.0)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, tableView.frame.size.width, 25.0)];
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:[NSString stringWithFormat:@"Section title %d", section +1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor blackColor]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0;
}

//=======================================================================
// Custom methods
//=======================================================================
#pragma mark - Custom methods
- (IBAction)cancelBtnPressed:(id)sender {
    [self showPopup:NO];
}

- (IBAction)saveBtnPressed:(id)sender {
    [self showPopup:NO];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sendData];
    });
}

- (IBAction)editBtnPressed:(id)sender {
    [self showPopup:YES];
}

- (void)showPopup:(BOOL)shouldShow {    
    if (shouldShow) {
        [self showSaveBtn:NO];
        
        [self.popupTextField setText:@""];
        [self.popupContainer setHidden:NO];
        [self.popupTextField becomeFirstResponder];
    } else {
        [self.popupContainer setHidden:YES];
        [self.popupTextField resignFirstResponder];
    }
}

- (void)showSaveBtn:(BOOL)shouldShow {
    if (shouldShow) {
        [self.popupSaveBtn setBackgroundColor:[UIColor greenColor]];
        [self.popupSaveBtn setEnabled:YES];
    } else {
        [self.popupSaveBtn setBackgroundColor:[UIColor redColor]];
        [self.popupSaveBtn setEnabled:NO];
    }
}

- (void)initialSetup {
    [self retrieveData];
    [self showPopup:NO];
    self.popopView.layer.cornerRadius = 8.0;
    self.popopView.layer.masksToBounds = YES;
}

//=======================================================================
// Data Handlers
//=======================================================================
#pragma mark - Data Handlers
- (void)retrieveData {
    
    [self.infoArray removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userId     = [[UserManager sharedInstance] userId];
    NSString *userToken  = [[UserManager sharedInstance] userToken];

    [params setObject:userId forKey:@"id"];
    [params setObject:userToken forKey:@"token"];    

    [[DataManager sharedInstance] postRequestWithParameters:params
                                                    atPath:@"users/points"
                                                   inBlock:^(id results){
                                                       if ([results respondsToSelector:@selector(objectForKey:)]) {
                                                           NSArray *contents = [results objectForKey:@"root"];
                                                           
                                                           for (NSDictionary *info in contents) {
                                                               Event *event = [[Event alloc] initWithInfo:[info objectForKey:@"Pair"]];
                                                               [self.infoArray addObject:event];
                                                           }
                                                           
                                                           //Dispaly results and refresh tableview
                                                           [_tableV reloadData];
                                                       }
                                                       
                                                       [SVProgressHUD dismiss];
                                                   }];
}

- (void)sendData {
    [SVProgressHUD showWithStatus:@"Sending" maskType:SVProgressHUDMaskTypeGradient];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userId     = [[UserManager sharedInstance] userId];
    NSString *userToken  = [[UserManager sharedInstance] userToken];
    NSString *phone      = self.popupTextField.text;
    
    [params setObject:userId forKey:@"id"];
    [params setObject:userToken forKey:@"token"];
    [params setObject:phone forKey:@"mobilenumber"];
    
    [[DataManager sharedInstance] postRequestWithParameters:params
                                                     atPath:@"users/sukidesu"
                                                    inBlock:^(id results){
                                                        NSString *result;
                                                        if ([results respondsToSelector:@selector(objectForKey:)]) {
                                                            result = [results objectForKey:@"game"];
                                                            
                                                            if (result) {
                                                                GameScreenViewController *controller = [[GameScreenViewController alloc] initWithNibName:@"GameScreen" bundle:nil];
                                                                controller.gameText = result;
                                                                controller.modalPresentationStyle = UIModalPresentationFullScreen;
                                                                controller.modalTransitionStyle = UIModalTransitionStylePartialCurl;
                                                                [self presentModalViewController:controller animated:YES];
                                                            }
                                                        }
                                                        
                                                        [SVProgressHUD dismiss];
                                                    }];
}

- (void)usePoints {
    [SVProgressHUD showWithStatus:@"Using Points..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userId     = [[UserManager sharedInstance] userId];
    NSString *userToken  = [[UserManager sharedInstance] userToken];
    
    [params setObject:userId forKey:@"id"];
    [params setObject:userToken forKey:@"token"];
    [params setObject:@"1" forKey:@"points"];
    
    [[DataManager sharedInstance] postRequestWithParameters:params
                                                     atPath:@"users/getpoints"
                                                    inBlock:^(id results){
                                                        NSLog(@"Results %@", results);
                                                        [SVProgressHUD dismiss];
                                                    }];
}

//=======================================================================
// UITextFieldDelegate methods
//=======================================================================
#pragma mark - UITextFieldDelegate methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL valid;
    
    // Build up the resulting string…
    NSMutableString *fullString = [[NSMutableString alloc] init];
    
    [fullString appendString:[textField.text substringWithRange:NSMakeRange(0, range.location)]];
    if (fullString.length < 4) {
        [fullString appendString:string];
        valid = YES;
        [self showSaveBtn:fullString.length == 4];
    } else {
        valid = NO;
        [self showSaveBtn:YES];
    }
    
    return valid;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self showSaveBtn:NO];
    return YES;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex!=alertView.cancelButtonIndex) {
        [self usePoints];
    }
}

@end
