//
//  UserInfo.m
//  Emerald
//
//  Created by Razvan on 7/8/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

//=======================================================================
// UserInfo - Private Interface
//=======================================================================
#import "UserInfo.h"

@interface UserInfo ()

@end

//=======================================================================
// Event - Initialization
//=======================================================================
@implementation UserInfo

- (id)initWithInfo:(NSDictionary *)information {
    self = [super init];
    if (!self) return nil;
    
    self.title = [information objectForKey:@"title"];
    self.points = [information objectForKey:@"points"];
    self.deadline = [information objectForKey:@"deadline"];
    self.imageURL = [information objectForKey:@"adurl"];
    self.eventId = [information objectForKey:@"id"];
    return self;
}

@end
