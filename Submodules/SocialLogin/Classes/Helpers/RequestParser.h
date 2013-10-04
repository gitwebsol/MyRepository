//
//  RequestParser.h
//  suregift
//
//  Created by Matteo Gobbi on 11/01/13.
//  Copyright (c) 2013 Matteo Gobbi. All rights reserved.
//

#import "GBThread.h"
#import "Constants.h"

@interface RequestParser : GBThread <NSURLConnectionDataDelegate> {
    NSMutableDictionary *dictParam;
}

@property (nonatomic, retain) NSString *strURL;
@property (nonatomic, retain) NSString *invoked_service;

- (void)addPostValue:(NSString *)value forKey:(NSString *)key;

@end
