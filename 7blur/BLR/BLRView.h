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

@class BLRColorComponents;
@interface BLRView : UIView

@property(nonatomic, weak) UIView *parent;
@property(nonatomic, assign) CGPoint location;
@property(nonatomic, assign) BlurType blurType;
@property(nonatomic, strong) BLRColorComponents *colorComponents;
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property(nonatomic, strong) IBOutlet UITextView *textView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;
@property(nonatomic, strong) dispatch_source_t timer;

+ (BLRView *) load:(UIView *) view;
+ (BLRView *) loadWithLocation:(CGPoint) point parent:(UIView *) view;

- (void) unload;
- (void) slideDown;
- (void) slideUp;
- (void) blurWithColor:(BLRColorComponents *) components;
- (void) blurWithColor:(BLRColorComponents *) components updateInterval:(float) interval;

@end

@interface BLRColorComponents : NSObject

@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, assign) CGFloat saturationDeltaFactor;
@property(nonatomic, strong) UIImage *maskImage;

+ (BLRColorComponents *) lightEffect;
+ (BLRColorComponents *) darkEffect;

@end