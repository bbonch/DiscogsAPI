//
//  SearchResult.h
//  DiscogsAPI
//
//  Created by Admin on 6/4/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property long identifier;
@property NSString *title;
@property NSString *resourceUrl;
@property NSString *url;
@property NSString *thumb;

@end
