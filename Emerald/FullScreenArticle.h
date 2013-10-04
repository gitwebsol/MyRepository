//
//  FullScreenArticle.h
//  Emerald
//
//  Created by ColtBoys on 12/27/12.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Config.h"
#import "ShareTools.h"
#import "LocalData.h"
#import "Tools.h"
#import "WebViewController.h"
#import "DownloadViewController.h"

@interface FullScreenArticle : UIViewController <UIWebViewDelegate,UIActionSheetDelegate,UIScrollViewDelegate>{
    IBOutlet UIWebView *webV;
    IBOutlet UIView *viewHeader;
    IBOutlet UILabel *lblTitle;
    ShareTools *sharing;
}
- (IBAction)pazzuleselect:(id)sender;
@property (nonatomic,retain) NSDictionary *content;
-(IBAction)Back:(id)sender;
-(IBAction)More:(id)sender;
@end
