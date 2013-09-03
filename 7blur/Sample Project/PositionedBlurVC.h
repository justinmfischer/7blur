//
//  PositionedBlurVC.h
//  7blur
//
//  Created by JUSTIN M FISCHER on 9/02/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "Constants.h"

@class BLRView;

@interface PositionedBlurVC : UIViewController

@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) IBOutlet UIView *backgroundView;
@property(nonatomic, strong) IBOutlet UIView *foregroundView;
@property(nonatomic, strong) BLRView *blrView;
@property(nonatomic, assign) ViewDisplayAction viewDisplayAction;
@property(nonatomic, strong) IBOutlet UIButton *toggleViewButton;

- (IBAction) toggleView:(id) sender;

@end
