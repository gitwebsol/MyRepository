//
//  MyDetailViewController.h
//  Emerald
//
//  Created by Me on 9/16/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"

@interface MyDetailViewController : UIViewController <UIAlertViewDelegate> {
    IBOutlet UILabel *lblTitle, *lblDate;
    IBOutlet UIImageView *imgBanner;
}

@property (nonatomic, retain) UserInfo *userInfo;

@end