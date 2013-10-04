//
//  WebViewController.m
//  Sample
//
//  Created by Adways on 12/06/28.
//  Copyright (c) 2012年 Adways. All rights reserved.
//

#import "WebViewController.h"
#import "NativeProtocol.h"
#import "DownloadViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // NativeProtocolを有効にする
        [ NSURLProtocol registerClass: [ NativeProtocol class] ];
        
        // NativeProtocolへのリクエストをViewControllerへ通知する
        NSNotificationCenter *center = [ NSNotificationCenter defaultCenter ];
        [ center addObserver:self selector:@selector(invokeNativeMethod:) name:@"invokeNativeMethod" object:nil ];
    }
    return self;
}

-(void)dealloc
{
    // NativeProtocolを無効にする
    [ NSURLProtocol unregisterClass: [ NativeProtocol class ]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super viewDidLoad];
    NSURL *myURL = [NSURL URLWithString:@"http://182.48.52.97/pazzule/"];
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
    [webView loadRequest:myURLReq];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// NativeProtocolの処理を行う
-(void)invokeNativeMethod : (NSNotification *)notification
{
    NativeProtocol *protocol = notification.object;
    NSURLRequest   *request  = protocol.request;
    
    // native://closeWebViewが指定された場合
    if ([request.URL.host isEqualToString:@"closeWebView"]) {
        [ self performSelectorOnMainThread:@selector(closeWebView) withObject:nil waitUntilDone:NO];
    }
    // native://getSystemInfoが指定された場合
    else if ([request.URL.host isEqualToString:@"getSystemInfo"]) {
        NSString *systemInfo = [ self getSystemInfo ];
        
        // 値を返す
        [protocol sendResponse: systemInfo];
    }
    
//    あさからのコード
//    -(void)invokeNativeMethod : (NSNotification *)notification{
//        NativeProtocol *protocol = notification.object;
//        NSURLRequest *request = protocol.request;
//        
//        if ([request.URL.host isEqualToString:@"post"]) {
//            [self performSelectorOnMainThread:@selector(PostData) withObject:nil waitUntilDone:NO];
//        }else if ([request.URL.host isEqualToString:@"reload"]) {
//            [self performSelectorOnMainThread:@selector(Reload) withObject:nil waitUntilDone:NO];
//        }else if ([request.URL.host isEqualToString:@"extarnal"]) {
//            NSString *query = [[request URL] query];
//            NSArray *array = [query componentsSeparatedByString:@"&"];
//            [self performSelectorOnMainThread:@selector(Safari:) withObject:array waitUntilDone:NO];
//            
//        }
//        
//    }
    
}

// WebViewを閉じる
-(void)closeWebView
{
    NSLog(@"aaaaaaaaaaaaaaa");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"完了しました"
            delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
    [alert show];
    
    DownloadViewController *controller = [[DownloadViewController alloc] initWithNibName:@"DownloadViewController" bundle:nil ];
    [ self presentModalViewController:controller  animated:YES ];
    
}

// システムの情報をWebView内に表示する。
-(NSString *)getSystemInfo
{
    // システム情報を取得する
    UIDevice *device = [ UIDevice currentDevice];
    NSString *systemInfo = [ NSString stringWithFormat:@"name=%@, version=%@",
                            device.systemName, 
                            device.systemVersion ];
    
    return systemInfo;
}

@end
