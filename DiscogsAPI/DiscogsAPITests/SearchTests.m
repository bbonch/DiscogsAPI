//
//  SearchTests.m
//  DiscogsAPI
//
//  Created by Admin on 5/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <Foundation/Foundation.h>
#import "Search.h"
#import "ArtistSearch.h"
#import "URLDataProviderSync.h"
#import "URLDataProviderAsync.h"
#import "SenAsyncTestCase.h"

@interface SearchTests : SenAsyncTestCase

@end

@implementation SearchTests

NSString * const testSearchQuery = @"http://api.discogs.com/database/search?type=artist";

-(void) testSearchPropertyArtist
{
    //Arrange
    Search *search = [Search new];
    [search setArtist:@"Dj Cam"];
    
    //Assert
    STAssertEqualObjects(@"Dj Cam", search.artist, @"");
}

-(void) testGetSearchQuery
{
    //Arrange
    Search *artistSearch = [ArtistSearch new];
    
    //Act
    [artistSearch GetSearchQuery];
    NSString *result = [[artistSearch queryBuilder] query];
    
    //Assert
    STAssertEqualObjects(testSearchQuery, result, @"");
}

-(void) testGetArtistSearchResultSync
{
    //Arrange
    Search *artistSearch = [ArtistSearch new];
    [artistSearch GetSearchQuery];
    QueryBuilder *queryBuilder = [artistSearch queryBuilder];
    [queryBuilder addPair:@"per_page" value:[NSString stringWithFormat:@"%i",11]];
    [queryBuilder addPair:@"page" value:[NSString stringWithFormat:@"%i",1]];
    id<DataProviderDelegate> provider = [URLDataProviderSync new];
    
    //Act
    NSString *searchQuery = [queryBuilder query];
    [provider getDataWithString:searchQuery];
    NSMutableData *jsonData = [provider receivedData];
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *jsonDictionary = object;
    NSArray *results = [jsonDictionary objectForKey:@"results"];
    SearchResult *searchResult = [artistSearch GetSearchResult:[results objectAtIndex:0]];
    
    //Assert
    STAssertNotNil(searchResult.title, @"");
}

-(void) testGetArtistSearchResultAsync
{
    //Arrange
    Search *artistSearch = [ArtistSearch new];
    [artistSearch GetSearchQuery];
    QueryBuilder *queryBuilder = [artistSearch queryBuilder];
    [queryBuilder addPair:@"per_page" value:[NSString stringWithFormat:@"%i",11]];
    [queryBuilder addPair:@"page" value:[NSString stringWithFormat:@"%i",1]];
    id<DataProviderDelegate> provider = [URLDataProviderAsync new];
    [provider setObserver:self];
    [provider setDataLoaded:@selector(dataLoaded)];
    
    //Act
    NSString *searchQuery = [queryBuilder query];
    [provider getDataWithString:searchQuery];
    [self waitForTimeoutInt:1];
    NSMutableData *jsonData = [provider receivedData];
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *jsonDictionary = object;
    NSArray *results = [jsonDictionary objectForKey:@"results"];
    SearchResult *searchResult = [artistSearch GetSearchResult:[results objectAtIndex:0]];
    
    //Assert
    STAssertNotNil(searchResult.title, @"");
}

-(void) dataLoaded
{
    [self notify:SenAsyncTestCaseStatusSucceeded];
}

@end
