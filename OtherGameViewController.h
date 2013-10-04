//
//  OtherGameViewController.h
//  Emerald
//
//  Created by inextsol on 10/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherGameViewController : UIViewController<UIWebViewDelegate>
{
    UIActivityIndicatorView *indicator;
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
