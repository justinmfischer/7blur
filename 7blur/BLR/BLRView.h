//
//  BLRView.h
//  7blur
//
//  Created by JUSTIN M FISCHER on 9/02/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

typedef enum {
    KBlurUndefined = 0,
    KStaticBlur = 1,
    KLiveBlur = 2

} BlurType;

@interface BLRView : UIView

@property(nonatomic, weak) UIView *parent;
@property(nonatomic, assign) CGPoint location;
@property(nonatomic, assign) BlurType blurType;
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;
@property(nonatomic, strong) dispatch_source_t timer;

+ (BLRView *) load:(UIView *) view;
+ (BLRView *) loadWithLocation:(CGPoint) point parent:(UIView *) view;

- (void) unload;
- (void) slideDown;
- (void) slideUp;
- (void) blur;
- (void) blurWithUpdateInterval:(float) interval;

@end