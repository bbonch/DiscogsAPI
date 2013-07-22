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
    
}

-(void) testGetLabelByIncorrectUrl
{
    
}

-(void) testGetLabelByIncorrectId
{
    
}

-(void) testGetLabelReleases
{
    
}

@end
