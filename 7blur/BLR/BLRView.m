//
//  UIDrinkDirectoryFiltersVC.m
//  drink-In-my-hand
//
//  Created by JUSTIN M FISCHER on 8/21/13.
//  Copyright (c) 2013 Fun Touch Apps, LLC. All rights reserved.
//

#import "BLRView.h"
#import "BLRConstants.h"
#import "UIImage+ImageEffects.h"

@interface BLRView ()

@end

@implementation BLRView

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

+ (BLRView *) load:(UIView *) parent {
    BLRView *view = [[[NSBundle mainBundle] loadNibNamed:@"BLRView" owner:nil options:nil] objectAtIndex:0];
    
    view.parent = parent;
    
    int w = view.frame.size.width;
    int h = view.frame.size.height;
    
    view.frame = CGRectMake(0, -(h + 64), w, h);
    
    return view;
}

-(void) awakeFromNib {
    self.gripBarView.layer.cornerRadius = 6;
    
    //[self liveBlurBackground];
}

- (void) unload {
    [self removeFromSuperview];
}

-(void) liveBlurBackground {
    self.timer = CreateDispatchTimer(.10f * NSEC_PER_SEC,
                                                   1ull * NSEC_PER_SEC,
                                                   dispatch_queue_create(KAsyncQueueName, NULL),
                                                   ^{ [self blur]; });
}

- (void) blurBackground {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [[[self window] screen] scale]);
    
    int x = 0;
    int y = 0;
    int w = CGRectGetWidth(self.parent.frame);
    int h = CGRectGetHeight(self.parent.frame);
    
    [self.parent drawViewHierarchyInRect:CGRectMake(x, y, w, h) afterScreenUpdates:NO];
    
    UIImage *newBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    newBGImage = [newBGImage applyTintEffectWithColor:[UIColor blackColor]];

    dispatch_sync(dispatch_get_main_queue(), ^{
        self.backgroundImageView.image = newBGImage;
    });
}

- (void) blur {
    dispatch_async(dispatch_queue_create(KAsyncQueueName, NULL), ^{
        [self blurBackground];
    });
}

    dispatch_source_t CreateDispatchTimer(uint64_t interval,
                                      uint64_t leeway,
                                      dispatch_queue_t queue,
                                      dispatch_block_t block) {
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                     0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    
    return timer;
}

- (void) slideDown {
    [UIView animateWithDuration:0.25f animations:^{
        int h = self.frame.size.height;
        
        self.frame = CGRectMake(0, 64, 320, h);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_queue_create(KAsyncQueueName, NULL), ^{
            [self blur];
        });
    }];
}

- (void) slideUp {
    [UIView animateWithDuration:0.15f animations:^{
        int h = self.frame.size.height;
        
        self.frame = CGRectMake(0, -(self.frame.size.height + 64), 320, h);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

@end
