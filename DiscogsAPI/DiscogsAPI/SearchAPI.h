//
//  SearchAPI.h
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResults.h"
#import "Search.h"

@interface SearchAPI : NSObject

+(SearchResults *) GetSearchResults:(Search *) search withPagination:(Pagination *) pagination;

@end
