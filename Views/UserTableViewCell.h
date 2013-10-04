//
//  UserTableViewCell.h
//  Emerald
//
//  Created by Razvan on 6/11/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"

//=======================================================================
// UserTableViewCell - Public Interface
//=======================================================================
@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnBg;

- (void)updateWithInformation:(UserInfo*)userInfo;

@end
