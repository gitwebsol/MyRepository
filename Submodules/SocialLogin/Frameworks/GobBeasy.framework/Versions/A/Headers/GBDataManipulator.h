//
//  GBDataManipulator.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 13/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBDataManipulator : NSObject {
    
}

+ (NSData *)dataToBase64FromData:(NSData *)data;
+ (NSData *)dataFromBase64Data:(NSData *)data;

@end
