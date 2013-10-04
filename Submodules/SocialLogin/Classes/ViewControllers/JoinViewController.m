//
//  JoinViewController.m
//  suregift
//
//  Created by Matteo Gobbi on 20/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import "JoinViewController.h"
#import "UserManager.h"

@implementation JoinViewController

@synthesize tb, btJoin, btCancell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.tb = nil;
    self.btJoin = nil;
    self.btCancell = nil;
    loadView = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/******/

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

/******/

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




-(IBAction)join:(id)sender {
    [self setModeLoading:YES];
    
    [tb setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
    
    NSString *name = ((UITextField *)[tb viewWithTag:1]).text;
    NSString *surname = ((UITextField *)[tb viewWithTag:2]).text;
    NSString *email = ((UITextField *)[tb viewWithTag:3]).text;
    NSString *emailC = ((UITextField *)[tb viewWithTag:4]).text;
    NSString *password = ((UITextField *)[tb viewWithTag:5]).text;
    NSString *passwordC = ((UITextField *)[tb viewWithTag:6]).text;
    
    
    //Controllo che le password coincidano
    
    //Controllo che l'email abbia una forma regolare
    
    //Controllo che le email coincidano
    
    name = [Utility encryptString:name];
    surname = [Utility encryptString:surname];
    email = [Utility encryptString:email];
    emailC = [Utility encryptString:emailC];
    password = [Utility encryptString:password];
    passwordC = [Utility encryptString:passwordC];
    
    //Creo la stringa di inserimento
    NSString *str = [URL_SERVER stringByAppendingString:@"register.php"];
    
    //Start parser thread
    if(joinParser == nil) {
        joinParser = [[RequestParser alloc] init];
    }
    [joinParser setStrURL:str];
    [joinParser addPostValue:email forKey:@"email"];
    [joinParser addPostValue:emailC forKey:@"emailC"];
    [joinParser addPostValue:password forKey:@"password"];
    [joinParser addPostValue:passwordC forKey:@"passwordC"];
    [joinParser addPostValue:name forKey:@"name"];
    [joinParser addPostValue:surname forKey:@"surname"];
    joinParser.delegate = self;
    [joinParser start];
}

-(IBAction)cancell:(id)sender {
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [self dismissModalViewControllerAnimated:YES];
}


//Login parser end
-(void) notifyThreadEnd:(NSDictionary *)responseDict {

//    [[UserManager sharedInstance] setUserId:@""];
//    [[UserManager sharedInstance] setUserToken:@""];
//    [[UserManager sharedInstance] saveUserInfo];
    
    [self setModeLoading:NO];

    if([[responseDict valueForKey:ERROR_KEY] isEqualToString:ERROR_CONNECTION]) {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Connection Error" message:@"There was an error connecting to the server. Make sure you have an active internet connection or try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString *response = [responseDict valueForKey:@"join"];
    
    NSString *message = [[NSString alloc] init];
    
    if([response isEqualToString:@"OKjoin"]) {
        message = @"Registration successful! Confirm your email by clicking on the link we sent you!";
        [self cancell:self];
    } else if([response isEqualToString:@"KOjoin"]) {
        message = @"Error in the sign in procedure.";
    } else if([response isEqualToString:@"INVALIDname"]) {
        message = @"Insert a valid name.";
    } else if([response isEqualToString:@"INVALIDsurname"]) {
        message = @"Insert a valid surbame.";
    } else if([response isEqualToString:@"EXISTemail"]) {
        message = @"Inserted email, is alredy in use. Choose another email.";
    } else if([response isEqualToString:@"INVALIDpass"]) {
        message = @"Invalid passowrd: password must be long 6 characters and it can contain only chars, numbers, and symbols dot and dash.";
    } else if([response isEqualToString:@"INVALIDmail"]) {
        message = @"Invalid email: Insert a valid email (ex. example@gmail.com)";
    } else if([response isEqualToString:@"INEQUALpass"]) {
        message = @"Password and its confirm, are inequal.";
    } else if([response isEqualToString:@"INEQUALmail"]) {
        message = @"Email and its confirm, are inequal.";
    }
    
    //Appare l'alert
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"SocialLogin" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [message release];
    
}


//Disabilita i comandi e attiva il loading grafico
-(void)setModeLoading:(BOOL)active {
    if(active) {
        if(loadView == nil) {
            loadView = [[GBLoadingView alloc] initWithFrame:CGRectMake(320/2-160/2, (480-64)/2-125/2, 160, 125) opacity:1.0 message:@"Registrazione in corso.." cornerRadius:10.0 activityStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loadView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
        }
        [self.view addSubview:loadView];
        [self.view setUserInteractionEnabled:NO];
        btJoin.enabled = NO;
    } else {
        [loadView removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        btJoin.enabled = YES;
    }
}


- (void)dealloc {
    [btJoin release];
    [btCancell release];
    [tb release];
    [super dealloc];
}

@end
