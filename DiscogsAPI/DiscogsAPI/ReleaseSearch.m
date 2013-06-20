//
//  ReleaseSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ReleaseSearch.h"

@implementation ReleaseSearch

-(NSString *) GetSearchQuery
{
    [super GetSearchQuery];
    [queryBuilder addPair:@"type" value:@"release"];
    return [queryBuilder query];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    return nil;
}

@end
