//
//  GBThread.m
//  suregift
//
//  Created by Matteo Gobbi on 19/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import "GBThread.h"

@interface GBThread () {
    NSAutoreleasePool *pool;
}
-(void)myThread:(id) obj;
-(void)threadDidStart;
-(void)threadDidEnd:(id) obj;
@end


@implementation GBThread

@synthesize delegate;

-(void) myThread:(id) obj {
    pool = [[NSAutoreleasePool alloc] init];

    [self threadDidStart];
    
    [pool release];
}

- (void)start {    
    [NSThread detachNewThreadSelector:@selector(myThread:) toTarget:self withObject:nil];
}


- (void)threadDidStart {
    //Da sostituire nella propria classe
}

-(void)threadDidEnd:(id) obj {
    [delegate notifyThreadEnd:(NSDictionary *)obj];
}

-(void)dealloc {
    [super dealloc];
}

@end
