//
//  LiveBlurVC.h
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "Constants.h"

@class BLRView;

@interface LiveBlurVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSArray *countriesArray;
@property(nonatomic, strong) BLRView *blrView;
@property(nonatomic, assign) ViewDirection viewDirection;
@property(nonatomic, strong) IBOutlet UIBarButtonItem *viewDirectionButton;

- (IBAction) toggleViewDirection:(id) sender;

@end
