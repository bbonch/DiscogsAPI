//
//  SearchAPI.m
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "SearchAPI.h"

@implementation SearchAPI

@synthesize dataProvider;

- (SearchResult *) GetSearchResult:(Search *) search
{
    NSString *searchQuery = [search GetSearchQuery];
    
    [dataProvider getDataWithString:searchQuery];
    NSMutableData *jsonData = [dataProvider receivedData];
    if (jsonData == nil)
    {
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Query is incorrect." userInfo:nil];
    }
    
    NSDictionary *jsonObject = nil;
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *jsonError = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError)
        {
            @throw [[NSException new] initWithName:@"JSONParserException" reason:@"Can't parse JSON." userInfo:nil];
        }
        else
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                jsonObject = object;
            }
            else
            {
                @throw [[NSException new] initWithName:@"JSONParserException" reason:@"JSON data is incorrect." userInfo:nil];
            }
        }
    }
    else
    {
        @throw [[NSException new] initWithName:@"PlatformException" reason:@"Incorrect IOS version. Required 5.0 or later." userInfo:nil];
    }
    
    SearchResult *searchResult = [search GetSearchResult:jsonObject];
    return searchResult;
}

@end
