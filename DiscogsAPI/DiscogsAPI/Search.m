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

- (void)setSearchParameter:(NSString *) string parameterInt:(int) value
{
    if (value)
    {
        [self.queryBuilder addPair:string value:[NSString stringWithFormat:@"%i",value]];
    }
}

- (void)setSearchParameter:(NSString *) string parameterString:(NSString *) value
{
    if (value)
    {
        [self.queryBuilder addPair:string value:value];
    }
}

-(NSString *) getSearchQuery
{
    return [queryBuilder query];
}

-(void) buildSearchQuery
{
    [self setSearchParameter:@"q" parameterString:self.q];
    
    [self setSearchParameter:@"title" parameterString:self.title];
    
    [self setSearchParameter:@"release_title" parameterString:self.releaseTitle];
    
    [self setSearchParameter:@"credit" parameterString:self.credit];
    
    [self setSearchParameter:@"artist" parameterString:self.artist];
    
    [self setSearchParameter:@"anv" parameterString:self.anv];
    
    [self setSearchParameter:@"label" parameterString:self.label];
    
    [self setSearchParameter:@"genre" parameterString:self.genre];
    
    [self setSearchParameter:@"style" parameterString:self.style];
    
    [self setSearchParameter:@"country" parameterString:self.country];
    
    [self setSearchParameter:@"year" parameterString:self.year];
    
    [self setSearchParameter:@"format" parameterString:self.format];
    
    [self setSearchParameter:@"catno" parameterString:self.catno];
    
    [self setSearchParameter:@"barcode" parameterString:self.barcode];
    
    [self setSearchParameter:@"track" parameterString:self.track];
    
    [self setSearchParameter:@"submitter" parameterString:self.submitter];
    
    [self setSearchParameter:@"contributor" parameterString:self.contributor];
}

-(QueryResult *) getSearchResults:(NSDictionary *)jsonData
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
        [[queryResults results] addObject:[self getSearchResult:result]];
    }
    
    return queryResults;
}

-(SearchResult *) getSearchResult:(NSDictionary *)jsonData
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
