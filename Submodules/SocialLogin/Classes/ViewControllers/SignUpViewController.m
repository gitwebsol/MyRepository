//
//  SignUpViewController.m
//  Emerald
//
//  Created by Razvan on 7/2/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "SignUpViewController.h"
#import "SVProgressHUD.h"

//=======================================================================
// SignUpViewController - Private Interface
//=======================================================================

@interface SignUpViewController ()

@end

//=======================================================================
// SignUpViewController - Implementation
//=======================================================================

@implementation SignUpViewController

//-----------------------------------------------------------------------
// Initialization
//-----------------------------------------------------------------------
#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    NSURL *url = [NSURL URLWithString:kRegistrationURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebview:nil];
    [super viewDidUnload];
}

//-----------------------------------------------------------------------
// Custom methods
//-----------------------------------------------------------------------
#pragma mark - Custom methods
- (IBAction)cancelBtnPressed:(id)sender {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}


//-----------------------------------------------------------------------
// UIWebViewDelegate methods
//-----------------------------------------------------------------------
#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
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

@end
