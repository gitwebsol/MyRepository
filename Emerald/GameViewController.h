//
//  GameViewController.h
//  Emerald
//
//  Created by Razvan on 6/27/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>

//=======================================================================
// GameViewController - Public Interface
//=======================================================================
@interface GameViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIView *popupContainer;
@property (weak, nonatomic) IBOutlet UIView *popopView;
@property (weak, nonatomic) IBOutlet UITextField *popupTextField;
@property (weak, nonatomic) IBOutlet UIButton *popupCancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *popupSaveBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
