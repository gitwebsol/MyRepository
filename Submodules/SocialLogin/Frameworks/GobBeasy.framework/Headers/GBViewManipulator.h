//
//  GBViewManipulator.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 19/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GBViewManipulator : NSObject {
    
}

+ (UIView *)setShadowForView:(UIView *)view withRadius:(float)radius opacity:(float)opacity color:(UIColor *)color offset:(CGSize)offset;

+ (UIView *)removeShadowForView:(UIView *)view;

@end
