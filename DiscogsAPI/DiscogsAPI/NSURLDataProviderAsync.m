//
//  NSURLDataProvider.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "NSURLDataProviderAsync.h"

static NSString * const EventName = @"DataHasLoaded";

@implementation NSURLDataProviderAsync

NSURLConnection *connection;

@synthesize receivedData;
@synthesize errorFromResponse;
@synthesize responceCode;
@synthesize dataLoaded;
@synthesize observer;

-(void) getDataWithUrl:(NSURL *)url
{
    if (dataLoaded == nil || observer == nil)
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:dataLoaded name:EventName object:self];
    
    NSURLRequest *request =
    [NSURLRequest requestWithURL:url
                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                  timeoutInterval:10.0];
    NSURLConnection *connection = connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection)
    {
        [connection start];
        self.receivedData = [NSMutableData data];
    }
}

-(void) getDataWithString:(NSString *)stringUrl
{
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
   [self getDataWithUrl:url];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    errorFromResponse = error;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventName object:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[NSNotificationCenter defaultCenter] postNotificationName:EventName object:self];
}
                         
@end
