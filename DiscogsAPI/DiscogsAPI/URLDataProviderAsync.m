//
//  NSURLDataProvider.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "URLDataProviderAsync.h"

static NSString * const EventName = @"DataHasLoaded";

@implementation URLDataProviderAsync

@synthesize errorFromResponse;
@synthesize receivedData;
@synthesize responceCode;
@synthesize observer;
@synthesize dataLoaded;

-(void) getDataWithUrl:(NSURL *)url
{
    if (self.dataLoaded == nil || self.observer == nil)
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self.observer selector:self.dataLoaded name:EventName object:self];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    self.receivedData = [NSMutableData data];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
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
