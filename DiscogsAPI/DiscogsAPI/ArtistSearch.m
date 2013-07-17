//
//  ArtistSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/5/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ArtistSearch.h"
#import "ArtistSearchResult.h"

@implementation ArtistSearch

-(void) GetSearchQuery
{
    [super GetSearchQuery];
    [self.queryBuilder addPair:@"type" value:@"artist"];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    ArtistSearchResult *sr = [ArtistSearchResult new];
    sr.identifier = (int)[jsonData objectForKey:@"id"];
    sr.resourceUrl = [jsonData objectForKey:@"resource_url"];
    sr.title = [jsonData objectForKey:@"title"];
    sr.thumb = [jsonData objectForKey:@"thumb"];
    sr.url = [jsonData objectForKey:@"url"];
    
    return sr;
}

@end
