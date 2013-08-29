//
//  CountryManager.h
//  7blur
//
//  Created by JUSTIN M FISCHER on 8/28/13.
//  Copyright (c) 2013 Justin M Fischer. All rights reserved.
//

@interface CountryManager : NSObject

@property(nonatomic, strong) NSDictionary *countryDictionary;
@property(nonatomic, strong) NSArray *countryCodes;
@property(nonatomic, strong) NSMutableArray *countryNames;

+ (CountryManager *) sharedManager;

@end
