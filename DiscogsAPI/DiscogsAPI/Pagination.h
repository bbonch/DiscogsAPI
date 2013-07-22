//
//  QueryObject.h
//  DiscogsAPI
//
//  Created by Admin on 5/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryBuilder.h"

@interface Pagination : NSObject

@property int page;
@property int perPage;
@property int pages;
@property NSString *nextUrl;
@property NSString *prevUrl;

@end
