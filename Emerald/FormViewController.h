//
//  FormViewController.h
//  Emerald
//
//  Created by Razvan on 6/11/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "UserManager.h"

//=======================================================================
// FormViewController - Public Interface
//=======================================================================
@interface FormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    GBLoadingView *loadView;
}

@property (weak, nonatomic) IBOutlet UITableView *tb;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSDictionary *articleContent;

@end
