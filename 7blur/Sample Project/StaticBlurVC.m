//
//  StaticBlurVC.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "StaticBlurVC.h"
#import "CountryManager.h"
#import "Utilities.h"
#import "CountryCell.h"
#import "BLRView.h"

@interface StaticBlurVC ()

@end

@implementation StaticBlurVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CountryCell"];
    
    //Load BLRView with UITableView as background content
    self.blrView = [BLRView load:self.tableView];
    
    //Change UITextView text color to white
    self.blrView.textView.textColor = [UIColor whiteColor];
    
    //Add BLRView to main view
    [self.view addSubview:self.blrView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return [[CountryManager sharedManager].countryCodes count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    CountryCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    
    if(cell == nil) {
        cell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountryCell"];
    }
    
    cell.countryName.text = [NSString stringWithFormat:@"%@", [[CountryManager sharedManager].countryNames objectAtIndex:indexPath.row]];
    
    cell.countryFlag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[CountryManager sharedManager].countryCodes objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (IBAction) toggleViewDirection:(id) sender {
    switch (self.viewDirection) {
        case KShouldMoveDown: {
            
            //Stop UITableView : UIScrollView from scrolling
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            
            //Add vignette
            [UIView animateWithDuration:.2f animations:^{
                self.blackoutView.alpha = .2f;
            } completion:^(BOOL finished) {
                
            }];

            //Static blur with dark color components
            [self.blrView blurWithColor:[BLRColorComponents darkEffect]];
            
            //Slide down - drop down style
            [self.blrView slideDown];
            
            self.viewDirection = KShouldMoveUp;
            self.viewDirectionButton.image = [UIImage imageNamed:@"Up-30x30"];
            
            break;
        }
            
        case KShouldMoveUp: {
            
            //Remove vignette
            [UIView animateWithDuration:.5f animations:^{
                self.blackoutView.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
            
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

- (void) viewWillDisappear:(BOOL) animated {
    
    //Remove BLRView
    [self.blrView unload];
}

@end
