//
//  QueryObject.m
//  DiscogsAPI
//
//  Created by Admin on 5/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "QueryObject.h"

@implementation QueryObject

-(QueryBuilder *) queryBuilder
{
    if (queryBuilder == nil)
    {
        queryBuilder = [QueryBuilder new];
    }
    
    return queryBuilder;
}

@end
