//
//  JoinViewController.h
//  suregift
//
//  Created by Matteo Gobbi on 20/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParser.h"

@interface JoinViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,  ThreadCallBack> {
    
    RequestParser *joinParser;
    GBLoadingView *loadView;
}

@property (nonatomic, retain) IBOutlet UITableView *tb;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *btJoin;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btCancell;

-(IBAction)join:(id)sender;
-(IBAction)cancell:(id)sender;
-(void) notifyThreadEnd:(NSDictionary *)responseDict;
-(void)setModeLoading:(BOOL)active;

@end
