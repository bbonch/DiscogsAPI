//
//  QueryBuilder.h
//  DiscogsAPI
//
//  Created by Admin on 5/28/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryBuilder : NSObject

@property (readonly) NSString *query;

-(void) initWithQuery:(NSString *)initQuery;
-(void) addPair:(NSString *)key value:(NSString *)value;

@end
