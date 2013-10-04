//
//  GBThread.h
//  suregift
//
//  Created by Matteo Gobbi on 19/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ThreadCallBack

- (void) notifyThreadEnd:(NSDictionary *)responseDict;

@end

@interface GBThread : NSObject {
    id<ThreadCallBack> delegate;
}

@property (nonatomic, assign) id<ThreadCallBack> delegate;

- (void)start;

@end
