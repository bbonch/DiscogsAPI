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
        NSException *ex  =  [[NSException new] initWithName:@"QueryException" reason:@"Query is incorrect." userInfo:nil];
        [ex raise];
        return nil;
    }
    
    HandleJSONBlock block = ^(NSDictionary *jsonData)
    {
        QueryResult *searchResults = [search GetSearchResults:jsonData];
        return searchResults;
    };
    
    return [Blocks handleJSON:jsonData withBlock:block];
    
}

@end
