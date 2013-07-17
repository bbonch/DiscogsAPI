//
//  ReleaseSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ReleaseSearch.h"
#import "ReleaseSearchResult.h"

@implementation ReleaseSearch

-(void) GetSearchQuery
{
    [super GetSearchQuery];
    [self.queryBuilder addPair:@"type" value:@"release"];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    ReleaseSearchResult *sr = [ReleaseSearchResult new];
    sr.identifier = (long)[jsonData objectForKey:@"id"];
    sr.resourceUrl = [jsonData objectForKey:@"resource_url"];
    sr.title = [jsonData objectForKey:@"title"];
    sr.thumb = [jsonData objectForKey:@"thumb"];
    sr.url = [jsonData objectForKey:@"url"];
    
    sr.styles = [jsonData objectForKey:@"style"];
    sr.formats = [jsonData objectForKey:@"format"];
    sr.country = [jsonData objectForKey:@"country"];
    sr.labels = [jsonData objectForKey:@"label"];
    sr.catno = [jsonData objectForKey:@"catno"];
    sr.year = [jsonData objectForKey:@"year"];
    sr.genres = [jsonData objectForKey:@"genre"];
    
    return sr;
}

@end
