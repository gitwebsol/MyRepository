//
//  GameScreenViewController.h
//  Emerald
//
//  Created by Razvan on 7/9/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>

//=======================================================================
// GameScreenViewController - Public Interface
//=======================================================================
@interface GameScreenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (strong, nonatomic) NSString *gameText;

@end
