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
}

- (void) unload {
    if(self.timer != nil) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    
    [self removeFromSuperview];
}

- (void) blurBackground {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [[[self window] screen] scale]);
        
        int x = 0;
        int y = -64;
        int w = CGRectGetWidth(self.parent.frame);
        int h = CGRectGetHeight(self.parent.frame);
        
        [self.parent drawViewHierarchyInRect:CGRectMake(x, y, w, h) afterScreenUpdates:NO];
        
        __block UIImage *newBGImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        dispatch_async(dispatch_queue_create(KAsyncQueueName, NULL), ^{
            newBGImage = [newBGImage applyTintEffectWithColor:self.blurColor];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.backgroundImageView.image = newBGImage;
            });
            
        });
    
    //NSLog(@"Fire");
}

- (void) blurWithColor:(UIColor *) color {
    self.blurColor = color;
    self.blurType = KStaticBlur;
    
    [self blurBackground];
}

- (void) blurWithColor:(UIColor *) color updateInterval:(float) interval {
    self.blurType = KLiveBlur;
    
    self.timer = CreateDispatchTimer(interval * NSEC_PER_SEC, 1ull * NSEC_PER_SEC, dispatch_get_main_queue(), ^{[self blurWithColor:color];
    });
}

dispatch_source_t CreateDispatchTimer(uint64_t interval, uint64_t leeway, dispatch_queue_t queue, dispatch_block_t block) {
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
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
        if(self.blurType == KStaticBlur) {
            [self blurWithColor: self.blurColor];
        }
    }];
}

- (void) slideUp {
    if(self.timer != nil) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    
    [UIView animateWithDuration:0.15f animations:^{
        int h = self.frame.size.height;
        
        self.frame = CGRectMake(0, -(h + 64), 320, h);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

@end
