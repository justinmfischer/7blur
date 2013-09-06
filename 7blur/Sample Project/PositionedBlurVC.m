//
//  StaticBlurVC.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "PositionedBlurVC.h"
#import "BLRView.h"

@interface PositionedBlurVC ()

@end

@implementation PositionedBlurVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.toggleViewButton.layer.cornerRadius = 8;
    
    [self bindAnimation];
}

- (NSArray *) imagesForAnimation {
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 1; i < 16; i++) {
        [images addObject:[UIImage imageNamed: [NSString stringWithFormat:@"sallie-gardner-300x200-%.2i", i]]];
    }
    
    return images;
}

- (void) bindAnimation {
    self.imageView.animationImages = [self imagesForAnimation];

    self.imageView.animationDuration = 1.2f;
    self.imageView.animationRepeatCount = 0;
    
    [self.imageView startAnimating];
}

- (IBAction) toggleView:(id) sender {
    switch (self.viewDisplayAction) {
        case KShouldPresent: {
            
            //Location point to place BLRView
            CGPoint point = CGPointMake(0, 200);
            
            //Load BLRView with UIView as background content
            self.blrView = [BLRView loadWithLocation:point parent:self.backgroundView];
            
            //Container foreground frame updated to match BLRView (x, y, w, h)
            self.foregroundView.frame = CGRectMake(point.x, point.y, CGRectGetWidth(self.blrView.frame), CGRectGetHeight(self.blrView.frame));
            
            //Add BLRView to foreground view
            [self.foregroundView addSubview:self.blrView];
            
            //Start live real time blur with .2f update interval
            [self.blrView  blurWithColor:[BLRColorComponents lightEffect] updateInterval:.2f];
            
            self.viewDisplayAction = KShouldDismiss;
            
            break;
        }
            
        case KShouldDismiss: {
            
            //Remove BLRView
            [self.blrView unload];
            
            self.viewDisplayAction = KShouldPresent;
            
            break;
        }
            
        default:
            break;
    }
}

- (void) viewWillDisappear:(BOOL) animated {
    
    //Remove BLRView if not done previously
    [self.blrView unload];
}

@end
