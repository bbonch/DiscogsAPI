//
//  SearchAPI.m
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "SearchAPI.h"
#import "URLDataProviderSync.h"

@implementation SearchAPI

+(QueryResult *) GetSearchResults:(Search *) search withPagination:(Pagination *)pagination
{
    [search GetSearchQuery];
    [[search queryBuilder] addPair:@"per_page" value:[NSString stringWithFormat:@"%i",pagination.perPage]];
    [[search queryBuilder] addPair:@"page" value:[NSString stringWithFormat:@"%i",pagination.page]];
    NSString *searchQuery = [[search queryBuilder] query];
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:searchQuery];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
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
                QueryResult *searchResults = [search GetSearchResults:jsonDictionary];
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
