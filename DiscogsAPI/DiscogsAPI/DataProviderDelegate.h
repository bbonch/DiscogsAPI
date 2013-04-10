//
//  DataProviderDelegate.h
//  DiscogsAPI
//
//  Created by Admin on 4/9/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProviderDelegate <NSObject>

@property NSError *errorFromResponse;
@property NSHTTPURLResponse * responceCode;
@property NSMutableData *receivedData;
@property SEL dataLoaded;
@property id observer;

-(void) getDataWithUrl:(NSURL *)url;
-(void) getDataWithString:(NSString *)stringUrl;

@end
