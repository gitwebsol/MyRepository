//
//  UserManager.m
//  Emerald
//
//  Created by Razvan on 6/5/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "UserManager.h"

static NSString     *kUserInfoKey   = @"UserInfoKey";
static NSString     *kUserIdKey     = @"UserIdKey";
static NSString     *kUserTokenKey  = @"UserTokenKey";
static NSString     *kUserLoginKey  = @"kUserLoginKey";

//=======================================================================
// UserManager - Implementation
//=======================================================================

@implementation UserManager

//-----------------------------------------------------------------------
// Initialization
//-----------------------------------------------------------------------
#pragma mark - Initialization
+ (id)sharedInstance {
    static dispatch_once_t pred;
    static UserManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


- (id)init {
    self = [super init];
    if (!self) return nil;
    
    [self initializeUserInfo];
    
    return self;
}

//-----------------------------------------------------------------------
// Data handlers
//-----------------------------------------------------------------------
#pragma mark - Data handlers
- (void)initializeUserInfo {
    //Extract the dictionary containing user information from NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *userInfo = [userDefaults objectForKey:kUserInfoKey];
    
    if (userInfo) {
        self.userId         = [userInfo objectForKey:kUserIdKey];
        self.userToken      = [userInfo objectForKey:kUserTokenKey];
        self.userLoggedIn   = [[userInfo objectForKey:kUserLoginKey] boolValue];
    } else {
        self.userId         = @"";
        self.userToken      = @"";
        self.userLoggedIn   = NO;
    }
}

- (void)saveUserInfo {
    //Store the dictionary containing user information in NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:self.userId? self.userId : @"" forKey:kUserIdKey];
    [info setObject:self.userToken? self.userToken : @"" forKey:kUserTokenKey];
    [info setObject:[NSNumber numberWithBool:self.userLoggedIn] forKey:kUserLoginKey];
    
    [userDefaults setObject:[NSDictionary dictionaryWithDictionary:info] forKey:kUserInfoKey];
    [userDefaults synchronize];
}

- (void)clearUserInfo {
    //Remove user information in NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserInfoKey];
    [userDefaults synchronize];
}

@end
