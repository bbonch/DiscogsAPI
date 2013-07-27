//
//  releaseAPITests.m
//  DiscogsAPI
//
//  Created by Admin on 7/17/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Release.h"
#import "ReleaseAPI.h"

@interface ReleaseAPITests : SenTestCase

@end

@implementation ReleaseAPITests

-(void) testGetReleaseById
{
    //Arrange
    long releaseId = 234;
    
    //Act
    Release *release = [ReleaseAPI GetReleaseById:releaseId];
    
    //Assert
    STAssertEqualObjects(release.name, @"Cabin Fever / Reaction Time", @"Release's name doesn't mutch!");
}

-(void) testReleaseByUrl
{
    //Arrange
    NSString *url = @"http://api.discogs.com/releases/234";
    
    //Act
    Release *release = [ReleaseAPI GetReleaseByUrl:url];
    
    //Assert
    STAssertEqualObjects(release.name, @"Cabin Fever / Reaction Time", @"Release's name doesn't mutch!");
}

@end
