//
//  GBURLCacheConnection.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 15/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBProgressView.h"

@protocol GBURLCacheConnectionDelegate;

@interface GBURLCacheConnection : NSObject {
    
	id <GBURLCacheConnectionDelegate> delegate;
    
	NSMutableData *receivedData;
    
    GBProgressView *prgView;
    NSObject *obj;
    
    int dataLength;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) GBProgressView *prgView;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSObject *obj;

- (id) initWithURL:(NSURL *)theURL delegate:(id<GBURLCacheConnectionDelegate>)theDelegate objectInfo:(NSObject *)objInfo andProgressView:(GBProgressView *)progressView;

@end


@protocol URLCacheConnectionDelegate<NSObject>

- (void) connectionDidFail:(GBURLCacheConnection *)theConnection;
- (void) connectionDidFinish:(GBURLCacheConnection *)theConnection;
- (void) notifyReceivingDataLength:(int)dataLength;
- (void) notifyTotalDataLength:(int)totalDataLength;

@end
