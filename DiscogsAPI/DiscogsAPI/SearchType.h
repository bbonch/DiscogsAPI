//
//  SearchType.h
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Artist,
    Release,
    Label
} SearchTypeEnum;

@interface SearchType : NSObject

@property SearchTypeEnum searchTypeEnum;

-(NSString *) toString;

@end
