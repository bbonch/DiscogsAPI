//
//  DataProviderDelegate.h
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProviderDelegate <NSObject>

-(NSData *) getDataWithUrl:(NSURL *)url;
-(NSData *) getDataWithString:(NSString *)stringUrl;

@end
