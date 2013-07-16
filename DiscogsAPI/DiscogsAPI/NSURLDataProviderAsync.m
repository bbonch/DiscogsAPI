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

@synthesize dataLoaded;
@synthesize observer;
@synthesize errorFromResponse;
@synthesize receivedData;
@synthesize responceCode;

-(void) getDataWithUrl:(NSURL *)url
{
    if (self.dataLoaded == nil || self.observer == nil)
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self.observer selector:self.dataLoaded name:EventName object:self];
    
    NSURLRequest *request =
    [NSURLRequest requestWithURL:url
                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                  timeoutInterval:10.0];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (self.connection)
    {
        [self.connection start];
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
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.receivedData = nil;
    self.errorFromResponse = error;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EventName object:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[NSNotificationCenter defaultCenter] postNotificationName:EventName object:self];
}
                         
@end
