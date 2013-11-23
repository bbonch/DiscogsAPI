//
//  ReleaseAPI.m
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ReleaseAPI.h"
#import "DataProviderDelegate.h"
#import "URLDataProviderSync.h"

@implementation ReleaseAPI

NSString * const BaseReleaseUrl = @"http://api.discogs.com/releases/";

+(Release *) getReleaseById:(long) releaseId
{
    return [self getReleaseByUrl:[BaseReleaseUrl stringByAppendingFormat:@"%li",releaseId]];
}

+(Release *) getReleaseByUrl:(NSString *) releaseUrl
{
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:releaseUrl];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
    {
        NSString *errorString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",errorString);
        
        NSException *ex =  [[NSException new] initWithName:@"QueryException" reason:@"Release url is incorrect." userInfo:nil];
        [ex raise];
    }
    
    HandleJSONBlock block = ^(NSDictionary *jsonData)
    {
        return [Release getRelease:jsonData];
    };
    
    return [Blocks handleJSON:jsonData withBlock:block];
}

+(QueryResult *) getReleasesByUrl:(NSString *) releasesUrl withPagination:(Pagination *) pagination
{
    QueryBuilder * queryBuilder = [[QueryBuilder alloc] initWithQuery:releasesUrl];
    [queryBuilder addPair:@"per_page" value:[NSString stringWithFormat:@"%i",pagination.perPage]];
    [queryBuilder addPair:@"page" value:[NSString stringWithFormat:@"%i",pagination.page]];
    releasesUrl = [queryBuilder query];
    
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:releasesUrl];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
    {
        NSString *errorString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",errorString);
        
        NSException *ex =  [[NSException new] initWithName:@"QueryException" reason:@"Release url is incorrect." userInfo:nil];
        [ex raise];
    }
    
    HandleJSONBlock block = ^(NSDictionary *jsonData)
    {
        NSArray * releases = [jsonData objectForKey:@"releases"];
        
        QueryResult *queryResults = [QueryResult new];
        NSDictionary *paginationD = [jsonData objectForKey:@"pagination"];
        NSDictionary *urls =[paginationD objectForKey:@"urls"];
        [queryResults setNextUrl:[urls objectForKey:@"next"]];
        [queryResults setPrevUrl:[urls objectForKey:@"prev"]];
        [queryResults setPerPage:[[paginationD objectForKey:@"per_page"] intValue]];
        [queryResults setPage:[[paginationD objectForKey:@"page"] intValue]];
        [queryResults setPages:[[paginationD objectForKey:@"pages"] intValue]];
        
        
        NSMutableArray * releasesArray = [[NSMutableArray alloc] initWithCapacity:[releases count]];
        for (NSDictionary * releaseD in releases)
        {
            NSString * releaseUrl = [releaseD objectForKey:@"resource_url"];
            Release * release = [self getReleaseByUrl:releaseUrl];
            if (release != nil)
            {
                [releasesArray addObject:release];
            }
        }
        
        [queryResults setResults:releasesArray];
        return queryResults;

    };
    
    return [Blocks handleJSON:jsonData withBlock:block];
}

@end
