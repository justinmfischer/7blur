//
//  Utilities.h
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

@interface Utilities : NSObject

+ (NSArray *) loadCountries;

@end

@interface Stopwatch : NSObject {
	// Name to be used for logging
	NSString* name;
	
	// Total run time
	NSTimeInterval runTime;
	
	// The start date of the currently active run
	NSDate* startDate;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, readonly) NSTimeInterval runTime;

- (id) initWithName:(NSString*)name;

- (void) start;
- (void) stop;
- (void) statistics;

@end