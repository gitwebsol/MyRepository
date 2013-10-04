//
//  GenericWebViewController.h
//  Emerald
//
//  Created by Razvan on 7/10/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>

//=======================================================================
// GenericWebViewController - Public Interface
//=======================================================================
@interface GenericWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong) NSString *URLstring;

@end
