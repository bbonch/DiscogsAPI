//
//  QueryObject.h
//  DiscogsAPI
//
//  Created by Admin on 5/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryBuilder.h"

@interface QueryObject : NSObject
{
    QueryBuilder *queryBuilder;
}

extern NSString * const BaseUrl;

@property int page;
@property int perPage;

-(QueryBuilder *) queryBuilder;

@end
