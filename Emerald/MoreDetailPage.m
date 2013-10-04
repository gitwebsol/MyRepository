//
//  MoreDetailPage.m
//  Emerald
//
//  Created by Me on 8/18/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "MoreDetailPage.h"
#import "FormViewController.h"
#import "SVProgressHUD.h"
#import "GenericWebViewController.h"



@interface MoreDetailPage ()

@end

@implementation MoreDetailPage
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
//    FormViewController *controller = [[FormViewController alloc] initWithNibName:@"Form" bundle:nil];
////    [controller setArticleContent:content];
//    [self presentModalViewController:controller animated:YES];
    
    //if([_parent isEqualToString:@"FullScreen"]) {

    if(![[UserManager sharedInstance] userLoggedIn]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"会員登録" message:@"会員登録しないと申し込みをすることはできません。会員登録をしますか？" delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
        [alert setTag:2];
        [alert show];
        //        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ポイントを消費していいですか？" delegate:self cancelButtonTitle:@"いいね" otherButtonTitles:@"はい", nil];
        [alert setTag:1];
        [alert show];
    }
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
            [params setObject:self.userInfo.points forKey:@"points"];
            NSLog(@"%@,%@,%@",userId,userToken,self.userInfo.points);
//            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"id", @"3", @"token", @"asfdsfasdfa", @"points", @"1", nil];
            [[DataManager sharedInstance] postRequestWithParameters:params
                                                             atPath:APPLY_URL
                                                            inBlock:^(id results) {
                                                                NSString *message = @"Success!";
                                                                if(results==nil) message = @"Failed!";
                                                                
                                                                NSString *r = [results objectForKey:@"response"];
                                                                NSLog(@"RESULTS %@",r);
                                                                
                                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Matikon"
                                                                    message:r delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
