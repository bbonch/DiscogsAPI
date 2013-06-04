//
//  QueryBuilder.m
//  DiscogsAPI
//
//  Created by Admin on 5/28/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "QueryBuilder.h"

@interface QueryBuilder()

@property (readwrite) NSString *query;

@end

@implementation QueryBuilder

@synthesize query;

-(void) initWithQuery:(NSString *)initQuery
{
    self.query = initQuery;
}

-(void) addPair:(NSString *)key value:(NSString *)value
{
    if (([key length] == 0) || ([value length] == 0))
    {
        @throw [[NSException new] initWithName:@"AurgumentException" reason:@"Key and value mustn't be empty" userInfo:nil];
    }
    
    if ([query length] == 0)
    {
        @throw [[NSException new] initWithName:@"StateException" reason:@"Query must be initialized" userInfo:nil];
    }
    
    NSRange rangeOfQuestion = [query rangeOfString:@"?"];
    
    if (rangeOfQuestion.location == NSNotFound)
    {
        @throw [[NSException new] initWithName:@"BadFormatException" reason:@"Query must be ended with ? mark" userInfo:nil];
    }
    
    NSUInteger positionOfLastCharacter = [query length] - 1;
    
    if (positionOfLastCharacter == rangeOfQuestion.location)
    {
        query = [query stringByAppendingFormat:@"%@=%@",key,value];
    }
    else
    {
        query = [query stringByAppendingFormat:@"%@%@=%@",@"&",key,value];
    }
}

@end
