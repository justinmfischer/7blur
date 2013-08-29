//
//  UIDrinkDirectoryFiltersVC.h
//  drink-In-my-hand
//
//  Created by JUSTIN M FISCHER on 8/21/13.
//  Copyright (c) 2013 Fun Touch Apps, LLC. All rights reserved.
//

typedef enum {
    KStaticBlur = 0,
    KLiveBlur = 1

} BlurType;

@interface BLRView : UIView

@property(nonatomic, weak) UIView *parent;
@property(nonatomic, assign) BlurType blurType;
@property(nonatomic, strong) UIColor *blurColor;
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;
@property(nonatomic, strong) dispatch_source_t timer;

+ (BLRView *) load:(UIView *) parent;

- (void) unload;
- (void) slideDown;
- (void) slideUp;
- (void) blurWithColor:(UIColor *) color;
- (void) blurWithColor:(UIColor *) color updateInterval:(float) interval;

@end