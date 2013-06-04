//
//  SearchAPI.h
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"
#import "Search.h"
#import "DataProviderDelegate.h"

@interface SearchAPI : NSObject

@property id<DataProviderDelegate> dataProvider;

- (SearchResult *) GetSearchResult:(Search *) search;

@end
