//
//  UserManager.h
//  Emerald
//
//  Created by Razvan on 6/5/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// UserManager - Public Interface
//=======================================================================
@interface UserManager : NSObject

@property (nonatomic, strong) NSString  *userId;
@property (nonatomic, strong) NSString  *userToken;
@property (nonatomic, assign) BOOL      *userLoggedIn;

+ (id)sharedInstance;
- (void)saveUserInfo;
- (void)clearUserInfo;

@end
