//
//  DataProviderTest.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSURLDataProviderSync.h"

@interface DataProviderTest : SenTestCase

@end

@implementation DataProviderTest

-(void) testGetStringDataFromUrl
{
    //Arrange
    id<DataProviderDelegate> dataProvider = [NSURLDataProviderSync new];
    NSString *urlString = @"http://api.discogs.com/database/search/per_page=1";
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    
    //Act
    NSData *actualResult = [dataProvider getDataWithUrl:url];
    
    //Assert
    STAssertTrue(actualResult.length > 0, @"There are no data");
}

@end
