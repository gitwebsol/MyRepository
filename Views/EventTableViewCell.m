//
//  EventTableViewCell.m
//  Emerald
//
//  Created by Razvan on 7/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "EventTableViewCell.h"

//=======================================================================
// EventTableViewCell - Implementation
//=======================================================================
@implementation EventTableViewCell

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

- (void)updateWithInformation:(Event *)event {
    [self.eventName setText:event.nameofevent];
    [self.name setText:event.name];
    [self.time setText:event.detailTime];
}

@end
