//
//  QueryBuilder.m
//  DiscogsAPI
//
//  Created by Admin on 5/28/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "QueryBuilder.h"

@interface QueryBuilder()

@property (readwrite) NSMutableString *query;

@end

@implementation QueryBuilder

-(id) initWithQuery:(NSString *)initQuery
{
    self = [super init];
    if (self)
    {
        _query = [[NSMutableString alloc] initWithString:initQuery];
    }
    
    return self;
}

-(void) addPair:(NSString *)key value:(NSString *)value
{
    if ([key length] == 0)
    {
        @throw [[NSException new] initWithName:@"AurgumentException" reason:@"Key and value mustn't be empty" userInfo:nil];
    }
    
    if ([self.query length] == 0)
    {
        @throw [[NSException new] initWithName:@"StateException" reason:@"Query must be initialized" userInfo:nil];
    }
    
    NSRange rangeOfQuestion = [self.query rangeOfString:@"?"];
    
    if (rangeOfQuestion.location == NSNotFound)
    {
        @throw [[NSException new] initWithName:@"BadFormatException" reason:@"Query must be ended with ? mark" userInfo:nil];
    }
    
    NSUInteger positionOfLastCharacter = [self.query length] - 1;
    
    if (positionOfLastCharacter == rangeOfQuestion.location)
    {
        [self.query appendFormat:@"%@=%@",key,value];
    }
    else
    {
        [self.query appendFormat:@"%@%@=%@",@"&",key,value];
    }
}

@end
