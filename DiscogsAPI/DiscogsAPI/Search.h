//
//  Search.h
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pagination.h"
#import "SearchResults.h"
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

-(void) GetSearchQuery;
-(SearchResults *) GetSearchResults:(NSDictionary *)jsonData;
-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData;
-(QueryBuilder *) queryBuilder;

@end
