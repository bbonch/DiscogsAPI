//
//  Search.m
//  DiscogsAPI
//
//  Created by Admin on 4/11/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Search.h"

@implementation Search

NSString * const BaseUrl = @"http://api.discogs.com/database/search?";

@synthesize q;
@synthesize title;
@synthesize releaseTitle;
@synthesize credit;
@synthesize artist;
@synthesize anv;
@synthesize label;
@synthesize genre;
@synthesize style;
@synthesize country;
@synthesize year;
@synthesize format;
@synthesize catno;
@synthesize barcode;
@synthesize track;
@synthesize submitter;
@synthesize contributor;

@end
