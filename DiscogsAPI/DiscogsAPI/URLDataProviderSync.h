//
//  NSURLDataProviderSync.h
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProviderDelegate.h"

NSString * const EventName;

@interface URLDataProviderSync : NSObject<DataProviderDelegate>

@end
