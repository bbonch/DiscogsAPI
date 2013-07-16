//
//  DataProviderTest.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSURLDataProviderAsync.h"
#import "NSURLDataProviderSync.h"

@interface DataProviderTest : SenTestCase

@end

@implementation DataProviderTest

id<DataProviderDelegate> dataProvider = nil;

-(void) setUp
{
    [super setUp];
    
    dataProvider = [NSURLDataProviderSync new];
    [dataProvider setObserver:self];
}

- (void) dataHasLoadedSuccess
{
    NSData *actualResult = [dataProvider receivedData];
    [self assertSuccess:actualResult];
}

- (void) dataHasLoadedFail
{
    NSData *actualResult = [dataProvider receivedData];
    [self assertFail:actualResult error:[dataProvider errorFromResponse]];
}

-(void) assertSuccess:(NSData *)actualResult
{
    STAssertTrue(actualResult != nil, @"There are no data");
    STAssertTrue(actualResult.length > 0, @"The data is empty");
}

-(void) assertFail:(NSData *)actualResult error:(NSError *)error
{
    STAssertTrue(actualResult == nil, @"There are data exist");
    STAssertNotNil(error, @"Error is nil");
}

-(void) testGetStringDataFromUrl
{
    //Arrange
    NSString *urlString = @"http://api.discogs.com/database/search?type=release&per_page=1";
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    [dataProvider setDataLoaded:@selector(dataHasLoadedSuccess)];
    
    //Act
    [dataProvider getDataWithUrl:url];
}

-(void) testGetStringDataFromWrongUrl
{
    //Arrange
    NSString *urlString = @"http://api.discogscom/database/search/per_page=1";
    NSURL * url = [NSURL URLWithString:urlString];
    [dataProvider setDataLoaded:@selector(dataHasLoadedFail)];
    
    //Act
    [dataProvider getDataWithUrl:url];
}

-(void) testGetStringDataFromString
{
    //Arrange
    NSString *urlString = @"http://api.discogs.com/database/search?type=release&per_page=1";
    [dataProvider setDataLoaded:@selector(dataHasLoadedSuccess)];
    
    //Act
    [dataProvider getDataWithString:urlString];
}

-(void) testGetStringDataFromWrongString
{
    //Arrange
    NSString *urlString = @"http://api.discogscom/database/search/per_page=1";
    [dataProvider setDataLoaded:@selector(dataHasLoadedFail)];
    
    //Act
    [dataProvider getDataWithString:urlString];
}

@end
