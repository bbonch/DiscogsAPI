//
//  SearchTypeTests.m
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SearchType.h"

@interface SearchTypeTests:SenTestCase

@end

@implementation SearchTypeTests

-(void) testToStringArtist
{
    //Arrange
    SearchType *searchType = [SearchType new];
    [searchType setSearchTypeEnum:Artist];
    
    //Act
    NSString *artistString = [searchType toString];
    
    //Assert
    STAssertEqualObjects(artistString, @"Artist", @"toString doesn't work");
}

@end
