//
//  APIClient.m
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "APIClient.h"
#import "AFJSONRequestOperation.h"

//=======================================================================
// APIClient - Implementation
//=======================================================================

@implementation APIClient

//-----------------------------------------------------------------------
// Initialization
//-----------------------------------------------------------------------
#pragma mark - Initialization
+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    return self;
}

@end
