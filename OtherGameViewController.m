//
//  OtherGameViewController.m
//  Emerald
//
//  Created by inextsol on 10/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "OtherGameViewController.h"

@interface OtherGameViewController ()

@end

@implementation OtherGameViewController
@synthesize webView;
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
    webView.delegate=self;
    NSURL *urlApp = [NSURL URLWithString:@"http://reatomo.com/"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:urlApp];
    
    
    //[[UIApplication sharedApplication] openURL:urlApp];
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];
    indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(140, 260, 40, 40)];
    indicator.color=[UIColor grayColor];
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
	// Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [indicator stopAnimating];
    indicator.hidden= TRUE;
    NSLog(@"Web View started loading...");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    indicator.hidden= FALSE;
    [indicator startAnimating];
    NSLog(@"Web View Did finish loading");
}
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
