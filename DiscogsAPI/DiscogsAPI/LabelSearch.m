//
//  LabelSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/5/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "LabelSearch.h"

@implementation LabelSearch

-(NSString *) GetSearchQuery
{
    [super GetSearchQuery];
    [queryBuilder addPair:@"type" value:@"label"];
    return [queryBuilder query];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    return nil;
}

@end
