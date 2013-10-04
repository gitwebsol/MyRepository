//
//  DataManager.m
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "DataManager.h"
#import "APIClient.h"
#import "HttpErrorHandler.h"

//=======================================================================
// DataManager - Implementation
//=======================================================================

@implementation DataManager

//-----------------------------------------------------------------------
// Initialization
//-----------------------------------------------------------------------
#pragma mark - Initialization
+ (DataManager *)sharedInstance {
    static DataManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataManager alloc] init];
    });
    
    return _sharedClient;
}

// -----------------------------------------------------------------------------
// POST method
// -----------------------------------------------------------------------------
#pragma mark - POST method
- (void)postRequestWithParameters:(NSDictionary *)parameters
                           atPath:(NSString *)path
                          inBlock:(void (^)(id))block{
    
    [[APIClient sharedClient] postPath:path
                            parameters:parameters
                               success:^(AFHTTPRequestOperation *operation, id JSONResponse) {
                                   if (block) {
                                       block(JSONResponse);
                                   }
                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   // we handle the error case in block with a message
                                   [HttpErrorHandler displayError:error];
                                   
                                   if (block) {
                                       block(nil);
                                   }
                               }];
}

// -----------------------------------------------------------------------------
// GET methods
// -----------------------------------------------------------------------------
#pragma mark - GET method
- (void)getRequestWithParameters:(NSDictionary *)parameters
                          atPath:(NSString *)path
                         inBlock:(void (^)(id))block{
    
    [[APIClient sharedClient] getPath:path
                           parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, id JSONResponse) {
                                   if (block) {
                                       block(JSONResponse);
                                   }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   // we handle the error case in block with a message
                                   [HttpErrorHandler displayError:error];
                                   
                                   if (block) {
                                       block(nil);
                                   }
                              }];
}

@end
