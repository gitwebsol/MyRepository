//
//  Event.h
//  Emerald
//
//  Created by Razvan on 7/4/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// Event - Public Interface
//=======================================================================
@interface Event : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameofevent;
@property (nonatomic, strong) NSString *detailTime;

- (id)initWithInfo:(NSDictionary *)information;

@end
