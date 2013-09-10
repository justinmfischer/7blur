//
// Copyright (c) 2013 Justin M Fischer
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

@property(nonatomic, strong) IBOutlet UITextView *textView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;

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

/// Blur color components.
///
@interface BLRColorComponents : NSObject

@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, assign) CGFloat saturationDeltaFactor;
@property(nonatomic, strong) UIImage *maskImage;

///Light color effect.
///
+ (BLRColorComponents *) lightEffect;

///Dark color effect.
///
+ (BLRColorComponents *) darkEffect;

///Coral color effect.
///
+ (BLRColorComponents *) coralEffect;

///Neon color effect.
///
+ (BLRColorComponents *) neonEffect;

///Sky color effect.
///
+ (BLRColorComponents *) skyEffect;

@end