//
//  SearchAPITests.m
//  DiscogsAPI
//
//  Created by Admin on 6/10/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>
#import "SearchAPI.h"
#import "Search.h"
#import "ReleaseSearch.h"
#import "ReleaseSearchResult.h"

@interface SearchAPITests : SenTestCase

@end

@implementation SearchAPITests

-(void) testGetSearchResultsForRelease
{
    //Arrange
    SearchAPI *searchAPI = [SearchAPI new];
    Search *search = [ReleaseSearch new];
    search.perPage = 1;
    search.year = @"1996";
    search.catno = @"34";
    
    //Act
    SearchResults *results = [searchAPI GetSearchResults:search];
    NSString *nextUrl = results.nextUrl;
    NSArray *searchResults = results.searchResults;
    ReleaseSearchResult *searchResult = [searchResults objectAtIndex:0];
    NSUInteger count = 1;
    
    //Assert
    STAssertEqualObjects(nextUrl, @"http://api.discogs.com/database/search?per_page=1&type=release&catno=34&page=2&year=1996", @"");
    STAssertEquals(count, [searchResults count], @"");
    STAssertEqualObjects(searchResult.catno, @"NOW 34", @"");
}

@end
