//
//  GBViewAnimation.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 20/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GBViewAnimation : NSObject {
    
}

+ (void)viewEnterFromRight:(UIView *)view withDuration:(float)seconds;
+ (void)viewEnterFromLeft:(UIView *)view withDuration:(float)seconds;
+ (void)viewEnterFromBottom:(UIView *)view withDuration:(float)seconds;
+ (void)viewEnterFromTop:(UIView *)view withDuration:(float)seconds;
+ (void)viewOutToRight:(UIView *)view withDuration:(float)seconds;
+ (void)viewOutToLeft:(UIView *)view withDuration:(float)seconds;
+ (void)viewOutToBottom:(UIView *)view withDuration:(float)seconds;
+ (void)viewOutToTop:(UIView *)view withDuration:(float)seconds;
+ (void)moveView:(UIView *)view fromPosition:(CGPoint)origP toPosition:(CGPoint)destP withDuration:(float)seconds;

@end
