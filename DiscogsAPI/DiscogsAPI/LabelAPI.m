//
//  LabelAPI.m
//  DiscogsAPI
//
//  Created by Admin on 7/18/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "LabelAPI.h"
#import "URLDataProviderSync.h"
#import "QueryBuilder.h"

@implementation LabelAPI

NSString * const BaseLabelUrl = @"http://api.discogs.com/labels/";

+(Label *) getLabelById:(long) labelId
{
    
    return [self getLabelByUrl:[BaseLabelUrl stringByAppendingFormat:@"%li",labelId]];
}

+(Label *) getLabelByUrl:(NSString *) labelUrl
{
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:labelUrl];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
    {
        NSException *ex  =  [[NSException new] initWithName:@"QueryException" reason:@"Label url is incorrect." userInfo:nil];
        [ex raise];
        return nil;
    }
    
    HandleJSONBlock block = ^(NSDictionary *jsonData)
    {
        return [Label getLabel:jsonData];
    };

    
    return [Blocks handleJSON:jsonData withBlock:block];
}

+(NSMutableArray *) getReleasesForLabel:(NSString *) releasesUrl withPagination:(Pagination *)pagination
{
    NSMutableString *url = [[NSMutableString alloc] initWithString:releasesUrl];
    [url appendString:@"?"];
    QueryBuilder *queryBuilder = [[QueryBuilder alloc] initWithQuery:url];
    int perPage = pagination == nil ? 50 : pagination.perPage;
    int page = pagination == nil ? 1 : pagination.page;
    [queryBuilder addPair:@"per_page" value:[NSString stringWithFormat:@"%i",perPage]];
    [queryBuilder addPair:@"page" value:[NSString stringWithFormat:@"%i",page]];
    
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:queryBuilder.query];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
    {
        NSException *ex  =  [[NSException new] initWithName:@"QueryException" reason:@"Label url is incorrect." userInfo:nil];
        [ex raise];
        return nil;
    }
    
    HandleJSONBlock block = ^(NSDictionary *jsonData)
    {
        NSArray *releases = [jsonData objectForKey:@"releases"];
        NSMutableArray *releasesIds = [NSMutableArray new];
        
        for (NSDictionary *release in releases)
        {
            [releasesIds addObject:[release objectForKey:@"id"]];
        }
        
        return releasesIds;
    };
    
    return [Blocks handleJSON:jsonData withBlock:block];
}

@end
