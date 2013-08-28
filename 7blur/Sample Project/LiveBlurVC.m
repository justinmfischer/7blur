//
//  LiveBlurVC.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "LiveBlurVC.h"
#import "Utilities.h"

@interface LiveBlurVC ()

@end

@implementation LiveBlurVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countriesArray = [Utilities loadCountries];
}

- (IBAction) toggleViewDirection:(id) sender {
    switch (self.viewDirection) {
        case KShouldMoveDown: {
            
            self.viewDirection = KShouldMoveUp;
            self.viewDirectionButton.image = [UIImage imageNamed:@"Up-30x30"];
            
            break;
        }
            
        case KShouldMoveUp: {
            
            self.viewDirection = KShouldMoveDown;
            self.viewDirectionButton.image = [UIImage imageNamed:@"Down-30x30"];
            
            break;
        }
        
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.countriesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.countriesArray objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
