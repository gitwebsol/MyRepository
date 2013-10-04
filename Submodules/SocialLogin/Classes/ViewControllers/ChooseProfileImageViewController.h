//
//  ChooseProfileImageViewController.h
//  suregift
//
//  Created by Matteo Gobbi on 31/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestParser.h"

@interface ChooseProfileImageViewController : UIViewController <ThreadCallBack, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    RequestParser *photoParser;
    GBLoadingView *loadView;
    NSString *str_image;
}

@property (retain, nonatomic) IBOutlet UIBarButtonItem *btDone;
@property (retain, nonatomic) IBOutlet UIImageView *imgProfile;
@property (retain, nonatomic) IBOutlet UIButton *btTakePhoto;
@property (retain, nonatomic) IBOutlet UIButton *btChoosePhoto;

- (IBAction)clickDone:(id)sender;
//- (IBAction)clickChoosePhoto:(id)sender;
//- (IBAction)clickTakePhoto:(id)sender;
- (IBAction)takePhotoClick:(id)sender;

-(void) notifyThreadEnd:(NSDictionary *)responseDict;
-(void)setModeLoading:(BOOL)active;

@end
