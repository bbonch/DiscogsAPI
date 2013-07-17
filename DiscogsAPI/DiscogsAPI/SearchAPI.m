//
//  SearchAPI.m
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "SearchAPI.h"
#import "NSURLDataProviderSync.h"

@implementation SearchAPI

- (SearchResults *) GetSearchResults:(Search *) search
{
    [search GetSearchQuery];
    NSString *searchQuery = [[search queryBuilder] query];
    id<DataProviderDelegate> dataProvider = [NSURLDataProviderSync new];
    [dataProvider getDataWithString:searchQuery];
    NSMutableData *jsonData = [dataProvider receivedData];
    if (jsonData == nil)
    {
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Query is incorrect." userInfo:nil];
    }
    
    NSDictionary *jsonDictionary = nil;
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
                jsonDictionary = object;
                SearchResults *searchResults = [search GetSearchResults:jsonDictionary];
                return searchResults;
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
}

@end
