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
#import "QueryResult.h"

@interface SearchAPITests : SenTestCase

@end

@implementation SearchAPITests

-(void) testGetSearchResultsForRelease
{
    //Arrange
    Search *search = [ReleaseSearch new];
    Pagination *pagination = [Pagination new];
    pagination.perPage = 1;
    search.year = @"1996";
    search.catno = @"34";
    
    //Act
    QueryResult *results = [SearchAPI GetSearchResults:search withPagination:pagination];
    NSString *nextUrl = results.nextUrl;
    NSArray *searchResults = results.results;
    ReleaseSearchResult *searchResult = [searchResults objectAtIndex:0];
    NSUInteger count = 1;
    
    //Assert
    STAssertEqualObjects(nextUrl, @"http://api.discogs.com/database/search?per_page=1&type=release&catno=34&page=2&year=1996", @"");
    STAssertEquals(count, [searchResults count], @"");
    STAssertEqualObjects(searchResult.catno, @"NOW 34", @"");
}

@end
