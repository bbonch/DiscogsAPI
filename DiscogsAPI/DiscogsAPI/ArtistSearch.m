//
//  ArtistSearch.m
//  DiscogsAPI
//
//  Created by Admin on 6/5/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "ArtistSearch.h"

@implementation ArtistSearch

-(NSString *) GetSearchQuery
{
    return @"Artist";
}

-(SearchResult *) GetSearchResult
{
    return nil;
}

@end
