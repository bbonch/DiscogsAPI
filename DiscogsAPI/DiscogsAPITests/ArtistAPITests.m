//
//  ArtistAPITests.m
//  DiscogsAPI
//
//  Created by Admin on 7/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Artist.h"
#import "ArtistAPI.h"

@interface ArtistAPITests : SenTestCase

@end

@implementation ArtistAPITests

-(void) testGetArtistByUrl
{
    //Arrange
    NSString *url = @"http://api.discogs.com/artists/234";
    
    //Act
    Artist *artist = [ArtistAPI GetArtistByUrl:url];
    
    //Assert
    STAssertEqualObjects(artist.name, @"Beanfield", @"Artist name doesn't mutch!");
}

-(void) testGetArtistByIncorrectUrl
{
    //Arrange
    NSString *url = @"http://api.discogs.com/artistsdef/234";
    
    //Assert
    STAssertNil([ArtistAPI GetArtistByUrl:url], @"Url is correct!");}

-(void) testGetArtistReleases
{
    //Arrange
    NSString *releasesUrl = @"http://api.discogs.com/artists/994/releases";
    
    //Act
    NSMutableArray *releasesIds = [ArtistAPI GetReleasesForArtist:releasesUrl withPagination:nil];
    NSUInteger count = 22;
    //Assert
    STAssertEquals([releasesIds count], count, @"GetReleasesForArtist doesn't work!");}

@end
