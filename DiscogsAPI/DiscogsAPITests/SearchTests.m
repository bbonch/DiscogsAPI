//
//  SearchTests.m
//  DiscogsAPI
//
//  Created by Admin on 5/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Search.h"
#import "ArtistSearch.h"

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
    NSString *result = [artistSearch GetSearchQuery];
    
    //Assert
    STAssertEqualObjects(testSearchQuery, result, @"");
}

@end
