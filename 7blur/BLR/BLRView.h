//
//  UIDrinkDirectoryFiltersVC.h
//  drink-In-my-hand
//
//  Created by JUSTIN M FISCHER on 8/21/13.
//  Copyright (c) 2013 Fun Touch Apps, LLC. All rights reserved.
//

@interface BLRView : UIView

@property(nonatomic, weak) UIView *parent;
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property(nonatomic, strong) IBOutlet UIView *gripBarView;
@property(nonatomic, strong) dispatch_source_t timer;

+ (BLRView *) load:(__weak UIView *) parent;

- (void) unload;
- (void) slideDown;
- (void) slideUp;
- (void) blur;

@end