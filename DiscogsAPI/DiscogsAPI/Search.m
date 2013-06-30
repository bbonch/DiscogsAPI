//
//  Search.m
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Search.h"

@implementation Search

NSString * const BaseUrl = @"http://api.discogs.com/database/search?";

@synthesize q;
@synthesize title;
@synthesize releaseTitle;
@synthesize credit;
@synthesize artist;
@synthesize anv;
@synthesize label;
@synthesize genre;
@synthesize style;
@synthesize country;
@synthesize year;
@synthesize format;
@synthesize catno;
@synthesize barcode;
@synthesize track;
@synthesize submitter;
@synthesize contributor;

-(QueryBuilder *) queryBuilder
{
    if (queryBuilder == nil)
    {
        queryBuilder = [QueryBuilder new];
    }
    
    return queryBuilder;
}

-(void) setQueryBuilder:(QueryBuilder *)newQueryBuilder
{
}

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

-(NSString *) GetSearchQuery
{
    [self.queryBuilder initWithQuery:BaseUrl];
    
    [self SetSearchParameter:@"per_page" parameterInt:self.perPage];
    
    [self SetSearchParameter:@"page" parameterInt:self.page];
    
    [self SetSearchParameter:@"q" parameterString:q];
    
    [self SetSearchParameter:@"title" parameterString:title];
    
    [self SetSearchParameter:@"release_title" parameterString:releaseTitle];
    
    [self SetSearchParameter:@"credit" parameterString:credit];
    
    [self SetSearchParameter:@"artist" parameterString:artist];
    
    [self SetSearchParameter:@"anv" parameterString:anv];
    
    [self SetSearchParameter:@"label" parameterString:label];
    
    [self SetSearchParameter:@"genre" parameterString:genre];
    
    [self SetSearchParameter:@"style" parameterString:style];
    
    [self SetSearchParameter:@"country" parameterString:country];
    
    [self SetSearchParameter:@"year" parameterString:year];
    
    [self SetSearchParameter:@"format" parameterString:format];
    
    [self SetSearchParameter:@"catno" parameterString:catno];
    
    [self SetSearchParameter:@"barcode" parameterString:barcode];
    
    [self SetSearchParameter:@"track" parameterString:track];
    
    [self SetSearchParameter:@"submitter" parameterString:submitter];
    
    [self SetSearchParameter:@"contributor" parameterString:contributor];
    
    return [self.queryBuilder query];
}

-(SearchResults *) GetSearchResults:(NSDictionary *)jsonData
{
    if (jsonData == nil)
    {
        @throw [[NSException new] initWithName:@"ArgumentException" reason:@"Argument is nil" userInfo:nil];
    }
    
    SearchResults *searchResults = [SearchResults new];
    NSDictionary *pagination = [jsonData objectForKey:@"pagination"];
    NSDictionary *urls =[pagination objectForKey:@"urls"];
    [searchResults setNextUrl:[urls objectForKey:@"next"]];
    
    NSArray *results = [jsonData objectForKey:@"results"];
    for (NSDictionary *result in results)
    {
        [searchResults setSearchResults:[NSMutableArray new]];
        [[searchResults searchResults] addObject:[self GetSearchResult:result]];
    }
    
    return searchResults;
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

@end
