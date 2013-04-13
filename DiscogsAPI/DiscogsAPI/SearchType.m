//
//  SearchType.m
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "SearchType.h"

@implementation SearchType

@synthesize searchTypeEnum;

-(NSString *) toString
{
    switch (searchTypeEnum) {
        case Artist:
            return @"Artist";
            break;
        case Release:
            return @"Release";
            break;
        case Label:
            return @"Label";
            break;
        default:
            return nil;
            break;
    }
}

@end
