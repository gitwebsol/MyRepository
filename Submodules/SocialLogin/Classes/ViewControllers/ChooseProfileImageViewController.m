//
//  ChooseProfileImageViewController.m
//  suregift
//
//  Created by Matteo Gobbi on 31/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import "ChooseProfileImageViewController.h"

@interface ChooseProfileImageViewController ()

@end

@implementation ChooseProfileImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _btDone = nil;
    _btChoosePhoto = nil;
    _btTakePhoto = nil;
    _imgProfile = nil;
    loadView = nil;
    photoParser = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_btDone release];
    [_imgProfile release];
    [_btTakePhoto release];
    [_btChoosePhoto release];
    [photoParser release];
    [super dealloc];
}

- (IBAction)clickDone:(id)sender {
    [self setModeLoading:YES];
    
    NSString *device = [Utility encryptString:[Utility getDeviceAppId]];
    NSString *session = [Utility encryptString:[Utility getSession]];
    NSString *method = [Utility encryptString:SERVICE_CHANGE_IMG_PROFILE];
    
    //Prendo e scalo immagine
    UIImage *image = [GBImageManipulator scaleImage:_imgProfile.image toSize:CGSizeMake(IMG_PROFILE_SCALE_W, IMG_PROFILE_SCALE_H) ];
    
    //Salvo se va in porto
    str_image = [[Utility encryptData:UIImageJPEGRepresentation(image, IMG_PROFILE_QUALITY) urlEncode:NO] retain];
    //Immagine encodata per essere inviata via url
    NSString *str_image_encoded = [Utility URLEncodedString_ch:str_image];
    
    
    //Creo la stringa di inserimento
    NSString *str = [URL_SERVER stringByAppendingString:@"request.php"];
    
    //Start parser thread
    if(photoParser == nil) {
        photoParser = [[RequestParser alloc] init];
    }
    [photoParser setStrURL:str];
    [photoParser setInvoked_service:SERVICE_CHANGE_IMG_PROFILE];
    [photoParser addPostValue:device forKey:@"device"];
    [photoParser addPostValue:session forKey:@"session"];
    [photoParser addPostValue:method forKey:@"method"];
    [photoParser addPostValue:str_image_encoded forKey:@"image"];
    [photoParser setDelegate:self];
    [photoParser start];
    
}

/*
 - (IBAction)clickChoosePhoto:(id)sender {
 }
 
 - (IBAction)clickTakePhoto:(id)sender {
 }
 */


-(void) notifyThreadEnd:(NSDictionary *)responseDict {
    [self setModeLoading:NO];
    
    if([[responseDict valueForKey:ERROR_KEY] isEqualToString:ERROR_CONNECTION]) {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Errore di connessione" message:@"C'è stato un errore durante la connessione al server. Assicurati di avere una connessione ad internet attiva oppure riprova più tardi, grazie." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString *logged = [responseDict valueForKey:@"logged"];
    
    if([logged isEqualToString:@"1"]) {
        //Sessione valida, controllo se l'inserimento è andato a buon fine
        NSString *response = [responseDict valueForKey:@"response"];
        
        if([response isEqualToString:@"-1"]) {
            //Appare l'alert
            CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Server Error" message:@"Error connect to database." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        } else if([response isEqualToString:@"1"]) {
            //Setto l'immagine restituita, la salvo cripatata e codificata nelle userdefault
            [Utility setDefaultValue:str_image forKey:USER_IMG_PROFILE];
        }
        
        //Tolgo la schermata di scelta immagine
        if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
            [self dismissViewControllerAnimated:YES completion:nil];
        else
            [self dismissModalViewControllerAnimated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInformationChanged" object:nil];
    } else if([logged isEqualToString:@"-1"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Server Error" message:@"Error connect to database." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else if([logged isEqualToString:@"0"]) {
        //Appare l'alert
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"SocialLogin" message:@"Session not valid: you must login again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

//Disabilita i comandi e attiva il loading grafico
-(void)setModeLoading:(BOOL)active {
    if(active) {
        if(loadView == nil) {
            loadView = [[GBLoadingView alloc] initWithFrame:CGRectMake(320/2-160/2, (480-64)/2-125/2, 160, 125) opacity:1.0 message:@"Save image.." cornerRadius:10.0 activityStyle:UIActivityIndicatorViewStyleWhiteLarge];
            loadView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
        }
        [self.view addSubview:loadView];
        [self.view setUserInteractionEnabled:NO];
        _btChoosePhoto.enabled = NO;
        _btTakePhoto.enabled = NO;
        _btDone.enabled = NO;
    } else {
        [loadView removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        _btChoosePhoto.enabled = YES;
        _btTakePhoto.enabled = YES;
        _btDone.enabled = YES;
    }
}


-(IBAction)takePhotoClick:(id)sender {
    
    int tag = ((UIButton*)sender).tag;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if (tag == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else return;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)])
        [self presentViewController:picker animated:YES completion:nil];
    else
        [self presentModalViewController:picker animated:YES];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *) picker {
    
    if ([picker respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [picker dismissViewControllerAnimated:YES completion:nil];
    else
        [picker dismissModalViewControllerAnimated:YES];
    
    [picker release];
    
}


- (void)imagePickerController:(UIImagePickerController *) picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    _imgProfile.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([picker respondsToSelector:@selector(dismissViewControllerAnimated:completion:)])
        [picker dismissViewControllerAnimated:YES completion:nil];
    else
        [picker dismissModalViewControllerAnimated:YES];
    
    [picker release];
    
}


@end
