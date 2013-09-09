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

/// A UIView subclass that supports live real time and static blurs. See https://github.com/justinmfischer/7blur
///
@interface BLRView : UIView

@property(nonatomic, weak) UIView *parent;
@property(nonatomic, assign) CGPoint location;
@property(nonatomic, assign) BlurType blurType;
@property(nonatomic, strong) BLRColorComponents *colorComponents;
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property(nonatomic, strong) IBOutlet UITextView *textView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;
@property(nonatomic, strong) dispatch_source_t timer;

/// Drop down menu style.
///
/// @param UIView as background content
/// @return A newly created BLRView instance
+ (BLRView *) load:(UIView *) view;

///Fixed position style.
///
/// @param Location CGPoint point
/// @param Parent UIView as background content
/// @return A newly created BLRView instance
+ (BLRView *) loadWithLocation:(CGPoint) point parent:(UIView *) view;

///Remove.
///
/// @brief Invalidates timers and removes view from superview.
/// @return void
- (void) unload;

///Down.
///
/// @brief Slides down drop down menu into place.
/// @return void
- (void) slideDown;

///Up.
///
/// @brief Slides up drop down menu.
/// @return void
- (void) slideUp;

///Static blur.
///
/// @brief Blur content with static blur.
/// @param BLRColorComponents as blur components
/// @return void
- (void) blurWithColor:(BLRColorComponents *) components;

//Live real time blur.
///
/// @brief Start live real time blur with update interval in seconds.
/// @param BLRColorComponents as blur components
/// @param Update interval float as interval for background content updates
/// @return void
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