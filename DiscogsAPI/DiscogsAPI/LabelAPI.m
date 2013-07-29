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

+(Label *) GetLabelById:(long) labelId
{
    
    return [self GetLabelByUrl:[BaseLabelUrl stringByAppendingFormat:@"%li",labelId]];
}

+(Label *) GetLabelByUrl:(NSString *) labelUrl
{
    id<DataProviderDelegate> dataProvider = [URLDataProviderSync new];
    [dataProvider getDataWithString:labelUrl];
    NSMutableData *jsonData = [dataProvider receivedData];
    NSHTTPURLResponse *responseCode = [dataProvider responceCode];
    
    if ([responseCode statusCode] == 404)
    {
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Label url is incorrect." userInfo:nil];
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
                return [Label GetLabel:jsonDictionary];
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

+(NSMutableArray *) GetReleasesForLabel:(NSString *) releasesUrl withPagination:(Pagination *)pagination
{
    QueryBuilder *queryBuilder = [QueryBuilder new];
    NSMutableString *url = [[NSMutableString alloc] initWithString:releasesUrl];
    [url appendString:@"?"];
    [queryBuilder initWithQuery:url];
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
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Label url is incorrect." userInfo:nil];
    }
    
    NSDictionary *jsonDictionary;
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
                NSArray *releases = [jsonDictionary objectForKey:@"releases"];
                NSMutableArray *releasesIds = [NSMutableArray new];
                
                for (NSDictionary *release in releases)
                {
                    [releasesIds addObject:[release objectForKey:@"id"]];
                }
                
                return releasesIds;
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
    
    return nil;
}

@end
