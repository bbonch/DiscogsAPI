//
//  NSURLDataProvider.h
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProviderDelegate.h"

@interface URLDataProviderAsync : NSObject<DataProviderDelegate,NSURLConnectionDataDelegate>
{
    @private NSURLConnection *connection;
}

@end
