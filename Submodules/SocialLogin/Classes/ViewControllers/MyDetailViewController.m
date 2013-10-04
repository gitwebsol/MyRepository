//
//  MyDetailViewController.m
//  Emerald
//
//  Created by Me on 9/16/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "MyDetailViewController.h"
#import "FormViewController.h"
#import "SVProgressHUD.h"
#import "GenericWebViewController.h"
#import "UserManager.h"

@interface MyDetailViewController ()

@end

@implementation MyDetailViewController

@synthesize userInfo;

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
    for(UIButton *btn in self.view.subviews) {
        if([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = 10.0;
        }
    }
    
    imgBanner.layer.cornerRadius = 20.0;
    
    [self loadUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pazzuleselect:(id)sender {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ポイントを消費していいですか？" delegate:self cancelButtonTitle:@"いいね" otherButtonTitles:@"はい", nil];
        [alert setTag:1];
        [alert show];
}

- (void) loadUserInfo {
    if(userInfo!=nil) {
        [lblTitle setText:userInfo.title];
        [lblDate setText:userInfo.deadline];
        imgBanner.layer.cornerRadius = 10;
        
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
        
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(concurrentQueue, ^{
            NSData *image = [NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.imageURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgBanner setImage:[UIImage imageWithData:image]];
                [SVProgressHUD dismiss];
            });
        });
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex!=alertView.cancelButtonIndex) {
        if(alertView.tag==1) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *userId     = [[UserManager sharedInstance] userId];
            NSString *userToken  = [[UserManager sharedInstance] userToken];
            [params setObject:userId forKey:@"id"];
            [params setObject:userToken forKey:@"token"];
            [params setObject:userInfo.eventId forKey:@"adevent"];
            NSLog(@"%@,%@,%@",userId,userToken,userInfo.eventId );
            [[DataManager sharedInstance] postRequestWithParameters:params
                                                             atPath:APPLY_URL
                                                            inBlock:^(id results) {
                                                                NSString *message = @"Success!";
                                                                if(results==nil) message = @"Failed!";
                                                                
                                                                NSString *r = [results objectForKey:@"response"];
                                                                NSLog(@"%@",r);
                                                                
                                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Matikon"
                                                                                                                message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                [alert setTag:3];
                                                                [alert show];
                                                            }];
        } else if(alertView.tag==2) {
            GenericWebViewController *controller = [[GenericWebViewController alloc] initWithNibName:@"WebView" bundle:nil];
            controller.URLstring = SIGN_UP_URL;
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            NSLog(@"Failed!!!");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
