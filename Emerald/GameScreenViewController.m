//
//  GameScreenViewController.m
//  Emerald
//
//  Created by Razvan on 7/9/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "GameScreenViewController.h"

//=======================================================================
// GameScreenViewController - Private Interface
//=======================================================================
@interface GameScreenViewController ()

@end

//=======================================================================
// GameScreenViewController - Implementation
//=======================================================================
@implementation GameScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gameLabel.text = self.gameText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setGameLabel:nil];
    [super viewDidUnload];
}

//=======================================================================
// Custom methods
//=======================================================================
#pragma mark - Custom methods
- (IBAction)btnPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
