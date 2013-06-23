//
//  ReleaseSearchResult.h
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "SearchResult.h"

@interface ReleaseSearchResult : SearchResult

@property NSArray *styles;
@property NSArray *formats;
@property NSString *country;
@property NSArray *labels;
@property NSString *catno;
@property NSString *year;
@property NSArray *genres;

@end
