//
//  LoginViewController.m
//  eventbook
//
//  Created by Matteo Gobbi on 01/12/11.
//  Copyright (c) 2011 Matteo Gobbi - Ingegnere Informatico libero professionista. All rights reserved.
//

#import "MasterViewController.h"
#import "JoinViewController.h"
#import "UserManager.h"
#import "SVProgressHUD.h"
#import "Utility.h"
#import "CustomAlertView.h"

@interface MasterViewController ()
    -(void)initializeView;
@end

@implementation MasterViewController

@synthesize tb, btJoin, btJoinFB;
//@synthesize joinViewC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAuthenticationAlert)
                                                 name:@"AuthenticationNeeded"
                                               object:nil];
    
    return self;
}

-(void)initializeView {
    
    [self.tb setBackgroundColor:[UIColor clearColor]];
    
    //Setto bottoni
    UIImage *buttonImageSign = [[UIImage imageNamed:@"button.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageSignHighlight = [[UIImage imageNamed:@"button-high.png"]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [_btSignIn setBackgroundImage:buttonImageSign forState:UIControlStateNormal];
    [_btSignIn setBackgroundImage:buttonImageSignHighlight forState:UIControlStateHighlighted];
    [_btSignIn.titleLabel setFont:[UIFont fontWithName:APP_FONT size:15]];
    
    
    UIImage *buttonImageJoin = [[UIImage imageNamed:@"orangeButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageJoinHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [btJoin setBackgroundImage:buttonImageJoin forState:UIControlStateNormal];
    [btJoin setBackgroundImage:buttonImageJoinHighlight forState:UIControlStateHighlighted];
    
    UIImage *buttonImageFB = [[UIImage imageNamed:@"blueButton.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageFBHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [btJoinFB setBackgroundImage:buttonImageFB forState:UIControlStateNormal];
    [btJoinFB setBackgroundImage:buttonImageFBHighlight forState:UIControlStateHighlighted];
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
    
//    self.title = @"ログイン画面";
    [self initializeView];
    
    //btLogin = [[UIBarButtonItem alloc] initWithTitle:@"Accedi" style:UIBarButtonItemStyleDone target:self action:@selector(login:)];
    
    //[self.navigationItem setRightBarButtonItem:btLogin];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *btLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout:)];
    [self.navigationItem setBackBarButtonItem:btLogout];
    
    //Controllo se c'è una sessione suregift attiva
    //in tal caso apro il programma, ma controllo prima se c'è anche una sessione fb attiva, xk in tal caso riapro anche quella
    //Controllo se c'è una sessione FB o una sessione in generale attiva
//    if(![[Utility getSession] isEqualToString:@""]) {
//        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//            // Yes, so just open the session (this won't display any UX).
//            //Questo mi rilogga con una nuova sessione
//            [self openSession];
//        } else {
//            //Sfrutto la session che ho già
//            [self goToCommunityWithPhotoController:[[Utility getDefaultValueForKey:USER_IMG_PROFILE] isEqualToString:@""]];
//        }
//    }

    if([[UserManager sharedInstance] userLoggedIn] &&
       [[UserManager sharedInstance] userToken] &&
       ![[[UserManager sharedInstance] userToken] isEqualToString:@""] &&
       [[UserManager sharedInstance] userId] &&
       ![[[UserManager sharedInstance] userId] isEqualToString:@""] ) {

        [self goToCommunityWithPhotoController:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    chooseProfileImageViewController = nil;
    communityTabBarController = nil;
    myViewController = nil;
    friendsViewController = nil;
    loadView = nil;
    loginParser = nil;
    btLogin = nil;
    self.btJoin = nil;
    self.btJoinFB = nil;
    self.tb = nil;
    
//    self.joinViewC = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        //Faccio logout
    }
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if([[UserManager sharedInstance] userLoggedIn]) {
        
    }
}

#pragma -
#pragma Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idCell = @"MyCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    
    if (cell == nil) {
        UIImage *icon;
        UIImageView *iconView;
        //UIColor *color = [UIColor colorWithRed:150.0/255.0 green:175.0/255.0 blue:195.0/255.0 alpha:1];
        
        //Colore testo placeholder etc - grigio scuro
        UIColor *color = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]];
        
        if ([indexPath section] == 0) {
            UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(65, 12, 185, 30)];
            txt.adjustsFontSizeToFitWidth = YES;
            [txt setBackgroundColor:[UIColor clearColor]];
            [txt setFont:[UIFont fontWithName:APP_FONT size:16]];
            [txt setTextColor:[UIColor colorWithRed:APP_TEXT_COLOR_GRAY green:APP_TEXT_COLOR_GRAY blue:APP_TEXT_COLOR_GRAY alpha:1.0]];
            if ([indexPath row] == 0) {
                icon = [UIImage imageNamed:@"icon_user.png"];
                iconView = [[UIImageView alloc] initWithImage:icon];
                [cell addSubview:iconView];
                [iconView setFrame:CGRectMake(25, 11, 21, 20)];
                
                //txt.placeholder = @"E-mail";
                txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"メールアドレス" attributes:@{NSForegroundColorAttributeName: color}];
                
                txt.keyboardType = UIKeyboardTypeDefault;
                txt.returnKeyType = UIReturnKeyNext;
                txt.tag = 1;
            }
            else {
                icon = [UIImage imageNamed:@"icon_lock.png"];
                iconView = [[UIImageView alloc] initWithImage:icon];
                [cell addSubview:iconView];
                [iconView setFrame:CGRectMake(27, 11, 18, 20)];
                
                //txt.placeholder = @"Password";
                txt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"パスワード" attributes:@{NSForegroundColorAttributeName: color}];

                txt.keyboardType = UIKeyboardTypeDefault;
                txt.returnKeyType = UIReturnKeyDone;
                txt.secureTextEntry = YES;
                txt.tag = 2;
            }
            
            [iconView setAlpha:0.5];
            txt.backgroundColor = [UIColor clearColor];
            txt.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
            txt.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
            txt.textAlignment = NSTextAlignmentLeft;
            
            txt.delegate = self;
            
            txt.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
            
            
            
            [txt setEnabled: YES];
            
            [cell addSubview:txt];
            
            
        }
    }
    
    /*
    
    if ([indexPath section] == 0) { // Email & Password Section
        if ([indexPath row] == 0) { // Email
            cell.textLabel.text = @"E-mail";
        }
        else {
            cell.textLabel.text = @"Password";
        }
    }
    */
    
    return cell;
    
}


#pragma mark -
#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSInteger nextTag = theTextField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [theTextField.superview.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [theTextField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


#pragma mark -
#pragma mark - My Methods

-(IBAction)login:(id)sender {
    [self.view endEditing:YES];
    
    [self loginWithSendConfirm:NO];
    
    
   // [self goToCommunity];
}


-(void)loginWithSendConfirm:(BOOL)send {
    [self setModeLoading:YES];
    
    NSString *email = ((UITextField *)[tb viewWithTag:1]).text;
    NSString *password = ((UITextField *)[tb viewWithTag:2]).text;
    
    email = [Utility encryptString:email];
    password = [Utility encryptString:password];
    NSString *device = [Utility encryptString:[Utility getDeviceAppId]];
    NSString *token = [Utility encryptString:[Utility getDeviceToken]];
    
    NSString *strSend = @"false";
    if(send) strSend = @"true";
    
    /*
    //Creo la stringa di inserimento
    NSString *str = [URL_SERVER stringByAppendingString:[NSString stringWithFormat:@"login.php?email=%@&password=%@&device=%@&token=%@&send_confirm=%@", email, password, device, token, [strSend stringByAddingPercentEscapesUsingEncoding: 4]]];
    */
    
    //POST
//    NSString *str = [URL_SERVER stringByAppendingString:@"login.php"];
    
    //Start parser thread
    if(loginParser == nil) {
        loginParser = [[RequestParser alloc] init];
    }
//    [loginParser setStrURL:str];
    [loginParser setStrURL:LOGIN_URL];
    [loginParser addPostValue:email forKey:@"email"];
    [loginParser addPostValue:password forKey:@"password"];
    [loginParser addPostValue:device forKey:@"device"];
    [loginParser addPostValue:token forKey:@"token"];
    [loginParser addPostValue:[strSend stringByAddingPercentEscapesUsingEncoding: 4] forKey:@"send_confirm"];
    loginParser.delegate = self;
    [loginParser start];
}


-(IBAction)join:(id)sender {
//    if(self.joinViewC == nil) {
//        self.joinViewC = [[JoinViewController alloc] initWithNibName:@"JoinViewController" bundle:[NSBundle mainBundle]];
//    }
//    
//    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])
//        [self presentViewController:joinViewC animated:YES completion:nil];
//    else
//        [self presentModalViewController:joinViewC animated:YES];
    
    SignUpViewController *signUpController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController"
                                                                                    bundle:[NSBundle mainBundle]];
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:signUpController animated:YES completion:nil];
    } else {
        [self presentModalViewController:signUpController animated:YES];
    }
}


//Login parser end
-(void) notifyThreadEnd:(NSDictionary *)responseDict {
    [self setModeLoading:NO];
    
    [[UserManager sharedInstance] setUserId:nil];
    [[UserManager sharedInstance] setUserToken:nil];
    [[UserManager sharedInstance] setUserLoggedIn:NO];
    [[UserManager sharedInstance] saveUserInfo];
    
    if (!responseDict) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Connection Error" message:@"A server error occured. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    if([[responseDict valueForKey:ERROR_KEY] isEqualToString:ERROR_CONNECTION]) {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Connection Error" message:@"There was an error connecting to the server. Make sure you have an active internet connection or try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString *login = [responseDict valueForKey:@"login"];
    
    if([login isEqualToString:@"1"] || [login isEqualToString:@"4"]) {
        
        [[UserManager sharedInstance] setUserId:[responseDict valueForKey:@"id"]];
        [[UserManager sharedInstance] setUserToken:[responseDict valueForKey:@"token"]];
        [[UserManager sharedInstance] setUserLoggedIn:YES];
        [[UserManager sharedInstance] saveUserInfo];
        
        self.title = @"Me";
        
        //Accesso avvenuto
        NSString *session = [responseDict valueForKey:@"session"];
        NSString *facebook = [responseDict valueForKey:@"facebook"];
        NSString *image = [responseDict valueForKey:@"img_profile"];
        
        session = [Utility decryptString:session];
        facebook = [Utility decryptString:facebook];
        
        if(![session isEqualToString:@""] && session != nil) {
            [Utility setDefaultValue:session forKey:USER_SESSION];
            [Utility setDefaultValue:facebook forKey:USER_FACEBOOK_LOGIN];
        }
        
        if(image) {
            [Utility setDefaultValue:image forKey:USER_IMG_PROFILE];
        }
        
        [self goToCommunityWithPhotoController:[login isEqualToString:@"4"]];
        
    } else if([login isEqualToString:@"-1"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Server Error" message:@"Error connect to database." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if([login isEqualToString:@"0"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"SocialLogin" message:@"E-mail and/or password wrong!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if([login isEqualToString:@"3"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"SocialLogin" message:@"Confirm e-mail send!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if([login isEqualToString:@"2"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"SocialLogin" message:@"You don't have confirmed your email address, do you want receive confirm email again?" delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Yes",nil];
        alert.tag = 1;
        [alert show];
        [alert release];
    }
    
}

-(void)goToCommunityWithPhotoController:(BOOL)flag {
    
    //Azzero i campi user e pass
    [((UITextField *)[tb viewWithTag:1]) setText:@""];
    [((UITextField *)[tb viewWithTag:2]) setText:@""];
    
    
//    friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:[NSBundle mainBundle]];
//    friendsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Friends" image:nil tag:0];

    myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:[NSBundle mainBundle]];
    myViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"My Profile" image:nil tag:1];
    
//    
//    communityTabBarController = [[CommunityTabBarControllerViewController alloc] init];
//    communityTabBarController.viewControllers = @[friendsViewController, myViewController];

    //Se devo visualizzare la scelta foto lo faccio subito
    [self.navigationController pushViewController:myViewController animated:YES];
    
    if(flag) {
        //if(chooseProfileImageViewController == nil) {
            chooseProfileImageViewController = [[ChooseProfileImageViewController alloc] initWithNibName:@"ChooseProfileImageViewController" bundle:[NSBundle mainBundle]];
        //}
        
//        if ([communityTabBarController respondsToSelector:@selector(presentViewController:animated:completion:)])
//            [communityTabBarController presentViewController:chooseProfileImageViewController animated:YES completion:nil];
//        else
//            [communityTabBarController presentModalViewController:chooseProfileImageViewController animated:YES];

        if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
            [self presentViewController:chooseProfileImageViewController animated:YES completion:nil];
        } else {
            [self presentModalViewController:chooseProfileImageViewController animated:YES];
        }
        
        //Controllo se devo scaricare l'immagine di facebook
        NSString *fb_login = [Utility getDefaultValueForKey:USER_FACEBOOK_LOGIN];
        if(![fb_login isEqualToString:@""] && fb_login != nil) {
            
            NSString *url_image = [NSString stringWithFormat:@"http://graph.facebook.com/%@",fb_login];
            url_image = [url_image stringByAppendingString:@"/picture?type=normal"];
            
            NSData *imageProfileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]];
            chooseProfileImageViewController.imgProfile.image = [[UIImage imageWithData:imageProfileData] retain];
        }
        
        
    }
}

-(void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 1:
            if(buttonIndex == 1) {
                //Apri una pagina che invia un email con il link di conferma
                [self loginWithSendConfirm:YES];
            }
            break;
            
        default:
            break;
    }
}


//Disabilita i comandi e attiva il loading grafico
-(void)setModeLoading:(BOOL)active {
//    if(active) {
//        if(loadView == nil) {
//            loadView = [[GBLoadingView alloc] initWithFrame:CGRectMake(320/2-160/2, (480-64)/2-125/2, 160, 125) opacity:1.0 message:@"Login.." cornerRadius:10.0 activityStyle:UIActivityIndicatorViewStyleWhiteLarge];
//            loadView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
//        }
//        [self.view addSubview:loadView];
//        [self.view setUserInteractionEnabled:NO];
//        btLogin.enabled = NO;
//    } else {
//        [loadView removeFromSuperview];
//        [self.view setUserInteractionEnabled:YES];
//        btLogin.enabled = YES;
//    }

    if(active) {
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    } else {
        [SVProgressHUD dismiss];
    }
}



- (IBAction)joinFB:(id)sender {
    //[self setModeLoading:YES];
    
    if (!FBSession.activeSession.isOpen) {
        [self openSession];
    }
    
    /*
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
            switch (state) {
                case FBSessionStateClosedLoginFailed:
                {
                    [self setModeLoading:NO];
                    
                    CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:@"Error"
                                                                        message:error.localizedDescription
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                default: {
                    [self getUserDetails];
                }
                    break;
            }
        }];
    } else {
        [self getUserDetails];
    }
     */
}


- (void)getUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 
                 //A questo punto prendo le informazioni che mi interessano e le invio al server
                 //che mi registra con facebook e mi logga. Nel caso fossi già registrato con facebook mi logga
                 //soltanto
                 NSDictionary *dict = (NSDictionary *)user;
                 
                 NSString *name = [Utility encryptString:user.first_name];
                 NSString *surname = [Utility encryptString:user.last_name];
                 NSString *gender = [Utility encryptString:[dict valueForKey:@"gender"]];
                 NSString *birthday = [Utility encryptString:user.birthday];
                 NSString *profile_id = user.id;
                 profile_id = [Utility encryptString:profile_id];
                 
                 //Faccio la registrazione e login
                 NSString *device = [Utility encryptString:[Utility getDeviceAppId]];
                 NSString *token = [Utility encryptString:[Utility getDeviceToken]];

                 //Creo la stringa di inserimento
                 NSString *str = [URL_SERVER stringByAppendingString:@"fb_login.php"];
                 
                 //Start parser thread
                 if(loginParser == nil) {
                     loginParser = [[RequestParser alloc] init];
                 }
                 [loginParser setStrURL:str];
                 [loginParser addPostValue:name forKey:@"name"];
                 [loginParser addPostValue:surname forKey:@"surname"];
                 [loginParser addPostValue:profile_id forKey:@"facebook"];
                 [loginParser addPostValue:device forKey:@"device"];
                 [loginParser addPostValue:token forKey:@"token"];
                 [loginParser addPostValue:birthday forKey:@"birthday"];
                 [loginParser addPostValue:gender forKey:@"gender"];
                 loginParser.delegate = self;
                 [loginParser start];
                 
                 
                 [self setModeLoading:NO];
             }
         }];
    }
}



/*****NEW APPROCH*****/

#pragma mark -
#pragma mark - FB state changed NEW

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            [self getUserDetails];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [FBSession.activeSession closeAndClearTokenInformation];
            [self setModeLoading:NO];
            
            break;
        default:
            break;
    }
    
    if (error) {
        CustomAlertView *alertView = [[CustomAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [self setModeLoading:YES];
    
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}
/*************/



- (void)showAuthenticationAlert {
    NSString *message = @"ログインしてください。ログインしたあとに、相性診断ゲームを使うことができます。";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [chooseProfileImageViewController release];
    [myViewController release];
    [friendsViewController release];
    [communityTabBarController release];
    [loadView release];
    [btJoin release];
    [btJoinFB release];
    [tb release];
//    [joinViewC release];
    [_btSignIn release];
    [super dealloc];
}



@end
