//
//  NSURLDataProvider.m
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "NSURLDataProviderAsync.h"

@implementation NSURLDataProviderAsync

@synthesize receivedData;

-(NSData *) getDataWithUrl:(NSURL *)url
{
    NSURLRequest *request =
    [NSURLRequest requestWithURL:url
                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                  timeoutInterval:10.0];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection)
    {
        self.receivedData = [NSMutableData data];
    }
    
    return receivedData;
}

-(NSData *) getDataWithString:(NSString *)stringUrl
{
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    return [self getDataWithUrl:url];
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{    
    NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataString);
}
                         
@end
