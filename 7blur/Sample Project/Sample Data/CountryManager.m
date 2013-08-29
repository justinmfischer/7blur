//
//  CountryManager.m
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

#import "CountryManager.h"

@implementation CountryManager

static CountryManager *sharedManager = nil;

+ (CountryManager *) sharedManager {
    @synchronized (self) {
        if (sharedManager == nil) {
            sharedManager = [[self alloc] init];
        }
    }
    
    return sharedManager;
}

- (id) init {
	self = [super init];
	
    if (self != nil) {
        [self load];
        [self sort];
    }
    
	return self;
}

-(void) load {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"];
    self.countryDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
}

-(void) sort {
    self.countryNames = [NSMutableArray array];
    self.countryCodes = [[self.countryDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *code in self.countryCodes) {
        [self.countryNames addObject:[self.countryDictionary objectForKey:code]];
    }
}

@end
