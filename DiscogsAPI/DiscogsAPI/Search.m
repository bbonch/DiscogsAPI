//
//  Search.m
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Search.h"

@implementation Search

NSString * const BaseSearchUrl = @"http://api.discogs.com/database/search?";

- (void)SetSearchParameter:(NSString *) string parameterInt:(int) value
{
    if (value)
    {
        [self.queryBuilder addPair:string value:[NSString stringWithFormat:@"%i",value]];
    }
}

- (void)SetSearchParameter:(NSString *) string parameterString:(NSString *) value
{
    if (value)
    {
        [self.queryBuilder addPair:string value:value];
    }
}

-(void) GetSearchQuery
{
    [self SetSearchParameter:@"q" parameterString:self.q];
    
    [self SetSearchParameter:@"title" parameterString:self.title];
    
    [self SetSearchParameter:@"release_title" parameterString:self.releaseTitle];
    
    [self SetSearchParameter:@"credit" parameterString:self.credit];
    
    [self SetSearchParameter:@"artist" parameterString:self.artist];
    
    [self SetSearchParameter:@"anv" parameterString:self.anv];
    
    [self SetSearchParameter:@"label" parameterString:self.label];
    
    [self SetSearchParameter:@"genre" parameterString:self.genre];
    
    [self SetSearchParameter:@"style" parameterString:self.style];
    
    [self SetSearchParameter:@"country" parameterString:self.country];
    
    [self SetSearchParameter:@"year" parameterString:self.year];
    
    [self SetSearchParameter:@"format" parameterString:self.format];
    
    [self SetSearchParameter:@"catno" parameterString:self.catno];
    
    [self SetSearchParameter:@"barcode" parameterString:self.barcode];
    
    [self SetSearchParameter:@"track" parameterString:self.track];
    
    [self SetSearchParameter:@"submitter" parameterString:self.submitter];
    
    [self SetSearchParameter:@"contributor" parameterString:self.contributor];
}

-(QueryResult *) GetSearchResults:(NSDictionary *)jsonData
{
    if (jsonData == nil)
    {
        @throw [[NSException new] initWithName:@"ArgumentException" reason:@"Argument is nil" userInfo:nil];
    }
    
    QueryResult *queryResults = [QueryResult new];
    NSDictionary *pagination = [jsonData objectForKey:@"pagination"];
    NSDictionary *urls =[pagination objectForKey:@"urls"];
    [queryResults setNextUrl:[urls objectForKey:@"next"]];
    [queryResults setPrevUrl:[urls objectForKey:@"prev"]];
    [queryResults setPerPage:[[pagination objectForKey:@"per_page"] intValue]];
    [queryResults setPage:[[pagination objectForKey:@"page"] intValue]];
    [queryResults setPages:[[pagination objectForKey:@"pages"] intValue]];
    
    NSArray *results = [jsonData objectForKey:@"results"];
    [queryResults setResults:[NSMutableArray new]];
    for (NSDictionary *result in results)
    {
        [[queryResults results] addObject:[self GetSearchResult:result]];
    }
    
    return queryResults;
}

-(SearchResult *) GetSearchResult:(NSDictionary *)jsonData
{
    SearchResult * sr = [SearchResult new];
    sr.identifier = (int)[jsonData objectForKey:@"id"];
    sr.resourceUrl = [jsonData objectForKey:@"resource_url"];
    sr.title = [jsonData objectForKey:@"title"];
    sr.thumb = [jsonData objectForKey:@"thumb"];
    sr.url = [jsonData objectForKey:@"url"];
    
    return sr;
}

-(QueryBuilder *) queryBuilder
{
    if (queryBuilder == nil)
    {
        queryBuilder = [[QueryBuilder alloc] initWithQuery:BaseSearchUrl];
    }
    
    return queryBuilder;
}

@end
