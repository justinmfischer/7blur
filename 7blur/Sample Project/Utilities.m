//
//  Utilities.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSArray *) loadCountries {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"];
    return [[[NSDictionary alloc] initWithContentsOfFile:path] allValues];
}

@end
