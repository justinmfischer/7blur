//
//  StaticBlurVC.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "PositionedBlurVC.h"
#import "CountryManager.h"
#import "Utilities.h"
#import "CountryCell.h"
#import "BLRView.h"

@interface PositionedBlurVC ()

@end

@implementation PositionedBlurVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toggleViewButton.layer.cornerRadius = 8;
    
    [self bindAnimation];
}

-(NSArray *) imagesForAnimation {
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 1; i < 16; i++) {
        [images addObject:[UIImage imageNamed: [NSString stringWithFormat:@"sallie-gardner-300x200-%.2i", i]]];
    }
    
    return images;
}

-(void) bindAnimation {
    self.imageView.animationImages = [self imagesForAnimation];

    self.imageView.animationDuration = 3;
    self.imageView.animationRepeatCount = 0;
    
    [self.imageView startAnimating];
}

- (IBAction) toggleView:(id) sender {
    switch (self.viewDisplayAction) {
        case KShouldPresent: {
            CGPoint point = CGPointMake(0, 200);
            
            self.blrView = [BLRView loadWithLocation:point parent:self.backgroundView];
            self.foregroundView.frame = CGRectMake(point.x, point.y, CGRectGetWidth(self.blrView.frame), CGRectGetHeight(self.blrView.frame));
            
            [self.foregroundView addSubview:self.blrView];
            [self.blrView  blurWithColor:[BLRColorComponents lightEffect] updateInterval:.2f];
            
            self.viewDisplayAction = KShouldDismiss;
            
            break;
        }
            
        case KShouldDismiss: {
            
            [self.blrView unload];
            
            self.viewDisplayAction = KShouldPresent;
            
            break;
        }
            
        default:
            break;
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.blrView unload];
}

@end
