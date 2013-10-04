//
//  FullScreenArticle.m
//  Emerald
//
//  Created by ColtBoys on 12/27/12.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "FullScreenArticle.h"
#import "Config.h"
#import "WebViewController.h"
#import "DownloadViewController.h"
#import "FormViewController.h"
#import "MapWebViewController.h"
#import "MoreDetailPage.h"
#import "GenericWebViewController.h"
#import "SVProgressHUD.h"

@interface FullScreenArticle ()

@end

@implementation FullScreenArticle
@synthesize content;
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
    
    for(UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            view.layer.cornerRadius = 10.0;
            CGRect frame = view.frame;
            if([Config isiPhone5]) frame.origin.y = 455;
            else frame.origin.y = 368;
            view.frame = frame;
        } else if([view isKindOfClass:[UIWebView class]]) {
            CGRect frame = view.frame;
            frame.size.width = 320;
            if([Config isiPhone5]) frame.size.height = 407;
            else frame.size.height = 320;
            frame.origin.y = 40;
            view.frame = frame;
        }
    }
    
    [LocalData addArticleToMemory:[content objectForKey:@"link"]];
    if ([UIScreen mainScreen].bounds.size.height == 400) {
        webV.frame = CGRectMake(webV.frame.origin.x, webV.frame.origin.y, webV.frame.size.width, self.view.frame.size.height-webV.frame.origin.y);
    }
    else
    {
        webV.frame = CGRectMake(webV.frame.origin.x, webV.frame.origin.y, webV.frame.size.width, self.view.frame.size.height-webV.frame.origin.y-88);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *urlString =[NSString stringWithFormat:@"http://iphone.lparty.jp/events/iphone/%@",[content objectForKey:@"id"]];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webV setDelegate:self];
    [webV loadRequest:request];
    
    lblTitle.text = [[[[[Config getTabControllers]componentsSeparatedByString:@","]objectAtIndex:self.tabBarController.selectedIndex]componentsSeparatedByString:@"/"]objectAtIndex:1];
    lblTitle.font = [Config getMainFont];
    webV.alpha=0;
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
}

-(IBAction)Back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)More:(id)sender{
    if ([Config isFavouritesEnabled]) {
        NSString *favStr;
        if ([LocalData isArticleFav:[self.content objectForKey:@"link"]]) {
            favStr = [Config getStringRemoveFromList];
        }
        else
        {
            favStr = [Config getStringReadItLater];
        }
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:[Config getStringCancel] destructiveButtonTitle:nil otherButtonTitles:favStr,[Config getStringShare], nil];
        [action showFromTabBar:self.tabBarController.tabBar];
    }
    else
    {
        [self ShareContent];
    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [LocalData addAFav:self.content];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Matikon"
                                                        message:@"Article added to Favorites."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if (buttonIndex==1){
        [self ShareContent];
    }
}
-(void)ShareContent{
    sharing=nil;
    sharing = [[ShareTools alloc]init];
    [sharing ShowShareToolsInController:self withMessage:[NSString stringWithFormat:@"%@ %@",[Config getFeedSharingMessage],[self.content objectForKey:@"title"]] andUrl:[self.content objectForKey:@"link"]];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    webView.alpha=1;
    
    CGRect frame = webView.frame;
    frame.size.width = 320;
    if([Config isiPhone5]) frame.size.height = 407;
    else frame.size.height = 320;
    frame.origin.y = 40;
    webView.frame = frame;
    
    [UIView commitAnimations];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    webView.alpha=1;
    [UIView commitAnimations];
}

- (IBAction)mapBtnPressed:(id)sender {
    NSString *googlemap = [content objectForKey:@"googlemap"];
    if ([googlemap isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Matikon" message:@"No map is available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        GenericWebViewController *web = [[GenericWebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        web.URLstring = googlemap;
        [self.navigationController pushViewController:web animated:YES];
    }
}

- (IBAction)pazzuleselect:(id)sender {
    MoreDetailPage *controller = [[MoreDetailPage alloc]initWithNibName:@"MoreDetailPage" bundle:nil];
    UserInfo *userInfo = [UserInfo new];
    userInfo.title = [content objectForKey:@"title"];
    userInfo.imageURL = [content objectForKey:@"image"];
    userInfo.deadline = [content objectForKey:@"date"];
    userInfo.points = @"";
    controller.userInfo = userInfo;
    controller.parent = @"FullScreen";
    [self.navigationController pushViewController:controller animated:YES];
}
@end
