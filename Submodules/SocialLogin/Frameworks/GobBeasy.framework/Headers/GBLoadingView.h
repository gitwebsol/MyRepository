//
//  GBLoadingView.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 19/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBLoadingView : UIView {
    UILabel *lblMessage;
    UIActivityIndicatorView *loadIndicator;
}

@property (nonatomic, retain) UILabel *lblMessage;
@property (nonatomic, retain) UIActivityIndicatorView *loadIndicator;

- (id)initWithFrame:(CGRect)frame opacity:(float)opacity message:(NSString *)message cornerRadius:(float)radius activityStyle:(UIActivityIndicatorViewStyle)style;

@end
