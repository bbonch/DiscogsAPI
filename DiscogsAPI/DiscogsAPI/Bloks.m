//
//  Bloks.m
//  DiscogsAPI
//
//  Created by Admin on 10/10/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Bloks.h"

@implementation Blocks

+(id) handleJSON:(NSMutableData *) jsonData withBlock:(HandleJSONBlock) block;
{
    NSDictionary *jsonDictionary = nil;
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *jsonError = nil;
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError)
        {
            NSException *ex  = [[NSException new] initWithName:@"JSONParserException" reason:@"Can't parse JSON." userInfo:nil];
            [ex raise];
            return nil;
        }
        else
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                jsonDictionary = object;
                return block(jsonDictionary);
            }
            else
            {
                NSException *ex  =  [[NSException new] initWithName:@"JSONParserException" reason:@"JSON data is incorrect." userInfo:nil];
                [ex raise];
                return nil;
            }
        }
    }
    else
    {
        NSException *ex  =  [[NSException new] initWithName:@"PlatformException" reason:@"Incorrect IOS version. Required 5.0 or later." userInfo:nil];
        [ex raise];
        return nil;
    }

}

@end
