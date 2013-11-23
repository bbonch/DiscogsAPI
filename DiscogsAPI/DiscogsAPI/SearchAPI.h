//
//  SearchAPI.h
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Search.h"

@interface SearchAPI : NSObject

+(QueryResult *) getSearchResults:(Search *) search withPagination:(Pagination *) pagination;

@end
