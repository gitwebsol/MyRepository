//
//  User.m
//  Emerald
//
//  Created by Razvan on 6/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "User.h"

//=======================================================================
// User - Private Interface
//=======================================================================
@interface User ()

@end

//=======================================================================
// User - Initialization
//=======================================================================
@implementation User

- (id)initWithInfo:(NSDictionary *)information {
    self = [super init];
    if (!self) return nil;
    
    self.name = [information objectForKey:@"name"];
    self.imageURL = [information objectForKey:@"adurl"];
    
    return self;
}

@end
