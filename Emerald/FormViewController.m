//
//  FormViewController.m
//  Emerald
//
//  Created by Razvan on 6/11/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "FormViewController.h"

//=======================================================================
// FormViewController - Private Interface
//=======================================================================

@interface FormViewController ()

@end

//=======================================================================
// FormViewController - Implementation
//=======================================================================

@implementation FormViewController

@synthesize tb;
@synthesize applyBtn;
@synthesize cancelBtn;
@synthesize titleLabel;

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

    [titleLabel setText:[self.articleContent objectForKey:@"title"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTb:nil];
    [self setCancelBtn:nil];
    [self setApplyBtn:nil];
    [self setTitleLabel:nil];
    loadView = nil;
    [super viewDidUnload];
}


//-----------------------------------------------------------------------
// UITableViewDataSource methods
//-----------------------------------------------------------------------
#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idCell = @"MyCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([indexPath section] == 0) {
            UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
            txt.adjustsFontSizeToFitWidth = YES;
            
            [txt setBackgroundColor:[UIColor clearColor]];
            [txt setFont:[UIFont fontWithName:APP_FONT size:16]];
            [txt setTextColor:[UIColor colorWithRed:APP_TEXT_COLOR_GRAY green:APP_TEXT_COLOR_GRAY blue:APP_TEXT_COLOR_GRAY alpha:1.0]];
            
            txt.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            txt.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            txt.textAlignment = NSTextAlignmentLeft;
            
            txt.delegate = self;
            
            txt.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
            [txt setEnabled: YES];
            
            switch ([indexPath row]) {
                case 0:
                    txt.placeholder = @"名前を入力";
                    txt.keyboardType = UIKeyboardTypeDefault;
                    txt.returnKeyType = UIReturnKeyNext;
                    txt.autocapitalizationType = UITextAutocapitalizationTypeWords;
                    txt.tag = 1;
                    break;
                case 1:
                    txt.placeholder = @"カナ文字入力";
                    txt.keyboardType = UIKeyboardTypeDefault;
                    txt.returnKeyType = UIReturnKeyNext;
                    txt.autocapitalizationType = UITextAutocapitalizationTypeWords;
                    txt.tag = 2;
                    break;
                case 2:
                    txt.placeholder = @"example@gmail.com";
                    txt.keyboardType = UIKeyboardTypeEmailAddress;
                    txt.returnKeyType = UIReturnKeyNext;
                    txt.tag = 3;
                    break;
                case 3:
                    txt.placeholder = @"example@gmail.com";
                    txt.keyboardType = UIKeyboardTypeEmailAddress;
                    txt.returnKeyType = UIReturnKeyNext;
                    txt.tag = 4;
                    break;
                case 4:
                    txt.placeholder = @"Password";
                    txt.keyboardType = UIKeyboardTypeDefault;
                    txt.returnKeyType = UIReturnKeyNext;
                    txt.secureTextEntry = YES;
                    txt.tag = 5;
                    break;
                case 5:
                    txt.placeholder = @"Repeat Password";
                    txt.keyboardType = UIKeyboardTypeDefault;
                    txt.returnKeyType = UIReturnKeyDone;
                    txt.secureTextEntry = YES;
                    txt.tag = 6;
                    break;
                default:
                    break;
            }
            [cell addSubview:txt];
        }
    }
    
    if ([indexPath section] == 0) { // Email & Password Section
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"苗字";
                break;
            case 1:
                cell.textLabel.text = @"名前";
                break;
            case 2:
                cell.textLabel.text = @"Email";
                break;
            case 3:
                cell.textLabel.text = @"確認";
                break;
            case 4:
                cell.textLabel.text = @"Password";
                break;
            case 5:
                cell.textLabel.text = @"確認";
                break;
            default:
                break;
        }
    }
    return cell;
}

//-----------------------------------------------------------------------
// UITextFieldDelegate methods
//-----------------------------------------------------------------------
#pragma mark - UITextFieldDelegate methods
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSInteger tag = textField.tag;
    
    [tb setContentOffset:CGPointMake(0, (tag-2)*44) animated:YES];
    
    return YES; // We do not want UITextField to insert line-breaks.
}


-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    NSInteger nextTag = theTextField.tag+1;
    
    
    // Try to find next responder
    UIResponder* nextResponder = [theTextField.superview.superview viewWithTag:nextTag];
    if (nextResponder) {
        
        [tb setContentOffset:CGPointMake(0, (nextTag-2)*44) animated:YES];
        
        [nextResponder becomeFirstResponder];
        
    } else {
        // Not found, so remove keyboard.
        
        [tb setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [theTextField resignFirstResponder];
        
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

//-----------------------------------------------------------------------
// IBAction methods
//-----------------------------------------------------------------------
#pragma mark - IBAction methods
- (IBAction)applyBtnPressed:(id)sender {
    [self setModeLoading:YES];

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self setModeLoading:NO];
    });
    
    [tb setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
    
//    NSString *name      = [self getTextFromCellWithTag:1];
//    NSString *surname   = [self getTextFromCellWithTag:2];
//    NSString *email     = [self getTextFromCellWithTag:3];
//    NSString *emailC    = [self getTextFromCellWithTag:4];
//    NSString *password  = [self getTextFromCellWithTag:5];
//    NSString *passwordC = [self getTextFromCellWithTag:6];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSString *userId     = [[UserManager sharedInstance] userId];
//    NSString *userToken  = [[UserManager sharedInstance] userToken];
//    
//    [params setObject:@"1" forKey:@"Id"];
    
    [[DataManager sharedInstance] postRequestWithParameters:params
                                                     atPath:@"users/test"
                                                    inBlock:^(id result){
                                             
    }];
}

- (IBAction)cancelBtnPressed:(id)sender {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

//-----------------------------------------------------------------------
// Custom methods
//-----------------------------------------------------------------------
#pragma mark - Custom methods
-(void)setModeLoading:(BOOL)active {
    if(active) {
        if(loadView == nil) {
            loadView = [[GBLoadingView alloc] initWithFrame:CGRectMake(320/2-160/2, (480-64)/2-125/2, 160, 125)
                                                    opacity:1.0 message:@"Please wait..." cornerRadius:10.0
                                              activityStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loadView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
        }
        [self.view addSubview:loadView];
        [self.view setUserInteractionEnabled:NO];
        applyBtn.enabled = NO;
    } else {
        [loadView removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        applyBtn.enabled = YES;
    }
}

- (NSString *)getTextFromCellWithTag:(int)tag {
    return ((UITextField *)[tb viewWithTag:tag]).text;
}

@end
