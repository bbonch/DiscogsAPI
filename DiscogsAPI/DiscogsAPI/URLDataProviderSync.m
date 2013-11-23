//
//  NSURLDataProviderSync.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "URLDataProviderSync.h"

static NSString * const EventName = @"DataHasLoaded";

@implementation URLDataProviderSync

@synthesize errorFromResponse;
@synthesize responceCode;
@synthesize receivedData;

-(void) getDataWithUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *errorLocal = nil;
    NSHTTPURLResponse *responceCodeLocal = nil; 
    
    receivedData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request returningResponse:&responceCodeLocal error:&errorLocal];
    errorFromResponse = errorLocal;
    responceCode = responceCodeLocal;
}

-(void) getDataWithString:(NSString *)stringUrl
{
    [self getDataWithUrl:[NSURL URLWithString:stringUrl]];
}

@end
