//
//  NSURLDataProviderSync.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "NSURLDataProviderSync.h"

static NSString * const EventName = @"DataHasLoaded";

@implementation NSURLDataProviderSync

@synthesize errorFromResponse;
@synthesize responceCode;
@synthesize receivedData;
@synthesize dataLoaded;
@synthesize observer;

-(void) getDataWithUrl:(NSURL *)url
{
    if (dataLoaded == nil || observer == nil)
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:dataLoaded name:EventName object:self];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"GET";
    request.URL = url;
    
    NSError *errorLocal = [NSError new];
    NSHTTPURLResponse *responceCodeLocal = nil;
    
    receivedData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request returningResponse:&responceCodeLocal error:&errorLocal];
    errorFromResponse = errorLocal;
    responceCode = responceCodeLocal;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventName object:self];
}

-(void) getDataWithString:(NSString *)stringUrl
{
    [self getDataWithUrl:[NSURL URLWithString:stringUrl]];
}

@end