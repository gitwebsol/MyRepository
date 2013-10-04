//
//  User.h
//  Emerald
//
//  Created by Razvan on 6/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// User - Public Interface
//=======================================================================
@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageURL;

- (id)initWithInfo:(NSDictionary *)information;

@end
