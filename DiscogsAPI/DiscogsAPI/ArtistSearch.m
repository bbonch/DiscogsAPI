//
//  ArtistSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/5/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ArtistSearch.h"

@implementation ArtistSearch

-(NSString *) GetSearchQuery
{
    [super GetSearchQuery];
    [queryBuilder addPair:@"type" value:@"artist"];
    return [queryBuilder query];
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    return nil;
}

@end
