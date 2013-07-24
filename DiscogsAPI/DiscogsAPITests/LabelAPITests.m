//
//  LabelAPITests.m
//  DiscogsAPI
//
//  Created by Admin on 7/17/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Label.h"
#import "LabelAPI.h"

@interface LabelAPITests : SenTestCase

@end

@implementation LabelAPITests

-(void) testGetLabelById
{
    //Arrange
    long labelId = 234;
    
    //Act
    Label *label = [LabelAPI GetLabelById:labelId];
    
    //Assert
    STAssertEqualObjects(label.name, @"Chain Reaction", @"Label's name doesn't mutch!");
}

-(void) testLabelByUrl
{
    //Arrange
    NSString *url = @"http://api.discogs.com/labels/234";
    
    //Act
    Label *label = [LabelAPI GetLabelByUrl:url];
    
    //Assert
    STAssertEqualObjects(label.name, @"Chain Reaction", @"Label's name doesn't mutch!");
}

-(void) testGetLabelByIncorrectUrl
{
    //Arrange
    NSString *url = @"http://api.discogs.com/ladwebels/234";
    
    //Assert
    STAssertThrows([LabelAPI GetLabelByUrl:url], @"Url is correct!");
}

-(void) testGetLabelByIncorrectId
{
    //Arrange
    long labelId = -1;
    
    //Assert
    STAssertThrows([LabelAPI GetLabelById:labelId], @"Id is correct!");
}

-(void) testGetLabelReleases
{
    //Arrange
    NSString *releasesUrl = @"http://api.discogs.com/labels/994/releases";
    
    //Act
    NSMutableArray *releasesIds = [LabelAPI GetReleasesForLabel:releasesUrl];
    NSUInteger count = 27;
    //Assert
    STAssertEquals([releasesIds count], count, @"GetReleasesForLabel doesn't work!");
}

@end
