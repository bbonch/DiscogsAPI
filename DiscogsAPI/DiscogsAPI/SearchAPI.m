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

+(QueryResult *) getSearchResults:(Search *) search withPagination:(Pagination *)pagination
{
    [search buildSearchQuery];
    [search setSearchParameter:@"per_page" parameterString:[NSString stringWithFormat:@"%i",pagination.perPage]];
    [search setSearchParameter:@"page" parameterString:[NSString stringWithFormat:@"%i",pagination.page]];
    
    NSString *searchQuery = [search getSearchQuery];
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
        QueryResult *searchResults = [search getSearchResults:jsonData];
        return searchResults;
    };
    
    return [Blocks handleJSON:jsonData withBlock:block];
    
}

@end
