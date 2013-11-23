//
//  Search.h
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pagination.h"
#import "QueryResult.h"
#import "SearchResult.h"

@interface Search : NSObject
{
    QueryBuilder *queryBuilder;
}

@property NSString *q;
@property NSString *title;
@property NSString *releaseTitle;
@property NSString *credit;
@property NSString *artist;
@property NSString *anv;
@property NSString *label;
@property NSString *genre;
@property NSString *style;
@property NSString *country;
@property NSString *year;
@property NSString *format;
@property NSString *catno;
@property NSString *barcode;
@property NSString *track;
@property NSString *submitter;
@property NSString *contributor;

-(void) buildSearchQuery;
-(NSString *) getSearchQuery;
-(QueryResult *) getSearchResults:(NSDictionary *)jsonData;
-(SearchResult *) getSearchResult:(NSDictionary *)jsonData;
- (void) setSearchParameter:(NSString *) string parameterString:(NSString *) value;
- (void) setSearchParameter:(NSString *) string parameterInt:(int) value;

@end
