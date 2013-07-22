//
//  LabelAPI.m
//  DiscogsAPI
//
//  Created by Admin on 7/18/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "LabelAPI.h"
#import "NSURLDataProviderSync.h"

@implementation LabelAPI

NSString * const BaseLabelUrl = @"http://api.discogs.com/labels/";

+(Label *) GetLabelById:(long) labelId
{
    
    return [self GetLabelByUrl:[BaseLabelUrl stringByAppendingFormat:@"%li",labelId]];
}

+(Label *) GetLabelByUrl:(NSString *) labelUrl
{
    id<DataProviderDelegate> dataProvider = [NSURLDataProviderSync new];
    [dataProvider getDataWithString:labelUrl];
    NSMutableData *jsonData = [dataProvider receivedData];
    
    if (jsonData == nil)
    {
        @throw [[NSException new] initWithName:@"QueryException" reason:@"Label url is incorrect." userInfo:nil];
    }
    
    NSDictionary *jsonDictionary = nil;
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *jsonError = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError)
        {
            @throw [[NSException new] initWithName:@"JSONParserException" reason:@"Can't parse JSON." userInfo:nil];
        }
        else
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                jsonDictionary = object;
                return [Label GetLabel:jsonDictionary];
            }
            else
            {
                @throw [[NSException new] initWithName:@"JSONParserException" reason:@"JSON data is incorrect." userInfo:nil];
            }
        }
    }
    else
    {
        @throw [[NSException new] initWithName:@"PlatformException" reason:@"Incorrect IOS version. Required 5.0 or later." userInfo:nil];
    }
}

+(NSMutableArray *) GetReleasesForLabel:(NSString *) releasesUrl
{
    return nil;
}

@end
