//
//  UserInfo.h
//  Emerald
//
//  Created by Razvan on 7/8/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// UserInfo - Public Interface
//=======================================================================
@interface UserInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *eventId;

- (id)initWithInfo:(NSDictionary *)information;

@end
