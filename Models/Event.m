//
//  Event.m
//  Emerald
//
//  Created by Razvan on 7/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "Event.h"

//=======================================================================
// Event - Private Interface
//=======================================================================
@interface Event ()

@end

//=======================================================================
// Event - Initialization
//=======================================================================
@implementation Event

- (id)initWithInfo:(NSDictionary *)information {
    self = [super init];
    if (!self) return nil;
    
    self.name = [information objectForKey:@"name"];
    self.nameofevent = [information objectForKey:@"nameofevent"];
    self.detailTime = [information objectForKey:@"detailtime"];
    
    return self;
}

@end
