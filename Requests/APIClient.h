//
//  APIClient.h
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "HttpErrorHandler.h"
#import <GrowthPush/GrowthPush.h>

//=======================================================================
// APIClient - Public Interface
//=======================================================================
@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

@end
