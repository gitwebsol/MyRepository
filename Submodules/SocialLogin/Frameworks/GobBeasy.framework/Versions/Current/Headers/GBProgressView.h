//
//  GBProgressView.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 15/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface GBProgressView : UIView {
	float minValue, maxValue;
	float currentValue;
	UIColor *lineColor, *progressRemainingColor, *progressColor;
    UILabel *lblFeed;
}

@property (nonatomic, retain) UILabel *lblFeed;

@property (nonatomic, readwrite) float minValue, maxValue, currentValue;
@property (nonatomic, retain) UIColor *lineColor, *progressRemainingColor, *progressColor;

-(id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame progressColor:(UIColor *)prC remainingColor:(UIColor *)remPrC borderColor:(UIColor *)brC;

-(void)setNewRect:(CGRect)newFrame;
-(void)setMinValue:(float)newMin;
-(void)setMaxValue:(float)newMax;
-(void)setCurrentValue:(float)newValue;
-(void)setLineColor:(UIColor *)newColor;
-(void)setProgressColor:(UIColor *)newColor;
-(void)setProgressRemainingColor:(UIColor *)newColor;


@end
