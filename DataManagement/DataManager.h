//
//  DataManager.h
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// DataManager - Public Interface
//=======================================================================
@interface DataManager : NSObject

+ (DataManager *)sharedInstance;
- (void)postRequestWithParameters:(NSDictionary *)parameters
                           atPath:(NSString *)path
                          inBlock:(void (^)(id))block;
- (void)getRequestWithParameters:(NSDictionary *)parameters
                          atPath:(NSString *)path
                         inBlock:(void (^)(id))block;
@end
