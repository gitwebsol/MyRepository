//
//  GenericWebViewController.m
//  Emerald
//
//  Created by Razvan on 7/10/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "GenericWebViewController.h"
#import "SVProgressHUD.h"

//=======================================================================
// GenericWebViewController - Private Interface
//=======================================================================
@interface GenericWebViewController ()

@end

//=======================================================================
// GenericWebViewController - Implementation
//=======================================================================
@implementation GenericWebViewController

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
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    NSURL *url = [NSURL URLWithString:self.URLstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview setScalesPageToFit:YES];
    [self.webview loadRequest:request];
    [self.webview setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebview:nil];
    [super viewDidUnload];
}

//=======================================================================
// UIWebViewDelegate methods
//=======================================================================
#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:error.localizedDescription
                                                  delegate:nil
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    [alert show];
}

//=======================================================================
// IBAction methods
//=======================================================================
#pragma mark - IBAction methods
- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
