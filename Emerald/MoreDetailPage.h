//
//  MoreDetailPage.h
//  Emerald
//
//  Created by Me on 8/18/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"

@interface MoreDetailPage : UIViewController <UIAlertViewDelegate> {
    IBOutlet UILabel *lblTitle, *lblDate;
    IBOutlet UIImageView *imgBanner;
}

@property (nonatomic, retain) NSString *parent;
@property (nonatomic, retain) UserInfo *userInfo;

-(IBAction)Back:(id)sender;
-(IBAction)pazzuleselect:(id)sender;

@end
