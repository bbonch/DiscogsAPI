//
//  QueryResult.h
//  DiscogsAPI
//
//  Created by Денис on 7/29/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pagination.h"

@interface QueryResult : Pagination

@property NSMutableArray *results;

@end
