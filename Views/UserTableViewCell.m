//
//  UserTableViewCell.m
//  Emerald
//
//  Created by Razvan on 6/11/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "UserTableViewCell.h"

//=======================================================================
// UserTableViewCell - Implementation
//=======================================================================
@implementation UserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithInformation:(UserInfo*)userInfo {
    [self.titleLabel setText:userInfo.title];
    [self.subtitleLabel setText:[NSString stringWithFormat:@"有効期限:\n%@", userInfo.deadline]];
    [self.pointsLabel setText:userInfo.points];
    [self.imageV setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.imageURL]]]];
    self.imageV.layer.cornerRadius = 8;
}

@end
