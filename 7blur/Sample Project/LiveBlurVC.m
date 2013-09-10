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
//  LiveBlurVC.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "LiveBlurVC.h"
#import "CountryManager.h"
#import "Utilities.h"
#import "CountryCell.h"
#import "BLRView.h"

@interface LiveBlurVC ()
@end

@implementation LiveBlurVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CountryCell"];
    
    //Load BLRView with UITableView as background content
    self.blrView = [BLRView load:self.tableView];
    
    //Add BLRView to main view
    [self.view addSubview:self.blrView];
}

- (IBAction) toggleViewDirection:(id) sender {
    switch (self.viewDirection) {
        case KShouldMoveDown: {
            
            //Start live real time blur with .2f update interval
            [self.blrView blurWithColor:[BLRColorComponents lightEffect] updateInterval:.2f];
            
            //Slide down - drop down style
            [self.blrView slideDown];
            
            self.viewDirection = KShouldMoveUp;
            self.viewDirectionButton.image = [UIImage imageNamed:@"Up-30x30"];
            
            break;
        }
            
        case KShouldMoveUp: {
            
            //Slide up
            [self.blrView slideUp];
            
            self.viewDirection = KShouldMoveDown;
            self.viewDirectionButton.image = [UIImage imageNamed:@"Down-30x30"];
            
            break;
        }
        
        default:
            break;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section {
    return [[CountryManager sharedManager].countryCodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    CountryCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    
    if(cell == nil) {
        cell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountryCell"];
    }
    
    cell.countryName.text = [NSString stringWithFormat:@"%@", [[CountryManager sharedManager].countryNames objectAtIndex:indexPath.row]];
    
    cell.countryFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[CountryManager sharedManager].countryCodes objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (void) viewWillDisappear:(BOOL) animated {
    
    //Remove BLRView
    [self.blrView unload];
}

@end
