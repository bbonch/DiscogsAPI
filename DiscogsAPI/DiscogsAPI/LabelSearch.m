//
//  LabelSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/5/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "LabelSearch.h"
#import "LabelSearchResult.h"

@implementation LabelSearch

-(void) GetSearchQuery
{
    [super GetSearchQuery];
    [self.queryBuilder addPair:@"type" value:@"label"];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    LabelSearchResult *sr = [LabelSearchResult new];
    sr.identifier = (int)[jsonData objectForKey:@"id"];
    sr.resourceUrl = [jsonData objectForKey:@"resource_url"];
    sr.title = [jsonData objectForKey:@"title"];
    sr.thumb = [jsonData objectForKey:@"thumb"];
    sr.url = [jsonData objectForKey:@"url"];
    
    return sr;
}

@end
