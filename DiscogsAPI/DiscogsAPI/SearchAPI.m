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
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Incorrect query" userInfo:nil];
    }
    
    SearchResult *searchResult = [search GetSearchResult];
    return searchResult;
}

@end
