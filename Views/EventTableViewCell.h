//
//  EventTableViewCell.h
//  Emerald
//
//  Created by Razvan on 7/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

//=======================================================================
// EventTableViewCell - Public Interface
//=======================================================================
@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

- (void)updateWithInformation:(Event *)event;

@end
