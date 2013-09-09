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

@interface Stopwatch ()

@property (nonatomic, retain) NSDate* startDate;

@end


@implementation Stopwatch

@synthesize name;
@synthesize runTime;
@synthesize startDate;

- (id) initWithName:(NSString*)_name
{
	if ((self = [super init])) {
		self.name = _name;
		runTime = 0;
	}
	
	return self;
}

- (void) start
{
	self.startDate = [NSDate date];
}

- (void) stop
{
	runTime += -[startDate timeIntervalSinceNow];
}

- (void) statistics
{
	NSLog(@"%@ finished in %f seconds.", name, runTime);
}

- (void) dealloc
{
	self.name = nil;
	self.startDate = nil;
	
}

@end