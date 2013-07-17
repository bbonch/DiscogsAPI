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
#import "NSURLDataProviderSync.h"

@interface SearchTests : SenTestCase

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

-(void) testGetArtistSearchResult
{
    //Arrange
    Search *artistSearch = [ArtistSearch new];
    [artistSearch setPerPage:11];
    id<DataProviderDelegate> provider = [NSURLDataProviderSync new];
    
    //Act
    [artistSearch GetSearchQuery];
    NSString *searchQuery = [[artistSearch queryBuilder] query];
    [provider getDataWithString:searchQuery];
    NSMutableData *jsonData = [provider receivedData];
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSDictionary *jsonDictionary = object;
    NSArray *results = [jsonDictionary objectForKey:@"results"];
    SearchResult *searchResult = [artistSearch GetSearchResult:[results objectAtIndex:0]];
    
    //Assert
    STAssertNotNil(searchResult.title, @"");
}

@end
