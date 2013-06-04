//
//  QueryBuilder.m
//  DiscogsAPI
//
//  Created by Admin on 5/28/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "QueryBuilder.h"

@interface QueryBuilderTests : SenTestCase

@end

@implementation QueryBuilderTests

-(void) testQueryBuilderInit
{
    //Arrange
    QueryBuilder *queryBuilder = [QueryBuilder new];
    
    //Act
    [queryBuilder initWithQuery:@"http://api.discogs.com/database/search?"];
    NSString *query = [queryBuilder query];
    
    //Assert
    STAssertEqualObjects(query, @"http://api.discogs.com/database/search?", @"Init doesn't work");
}

-(void) testQueryBuilderAddPair
{
    //Arrange
    QueryBuilder *queryBuilder = [QueryBuilder new];
    [queryBuilder initWithQuery:@"http://api.discogs.com/database/search?"];
    
    //Act
    [queryBuilder addPair:@"key1" value:@"value1"];
    [queryBuilder addPair:@"key2" value:@"value2"];
    NSString *query = [queryBuilder query];
    
    //Assert
    STAssertEqualObjects(query, @"http://api.discogs.com/database/search?key1=value1&key2=value2", @"");
}

-(void) testQueryBuilderCatchException
{
    //Arrange
    QueryBuilder *queryBuilder = [QueryBuilder new];
    [queryBuilder initWithQuery:@"http://api.discogs.com/database/search?"];
    
    //Assert
    STAssertThrows([queryBuilder addPair:@"" value:nil], @"");
}

@end
