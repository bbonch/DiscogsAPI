//
//  Label.h
//  DiscogsAPI
//
//  Created by Admin on 7/18/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Label : NSObject

@property long identifier;
@property NSString *name;
@property NSString *profile;
@property NSString *releasesUrl;
@property NSMutableArray *images;

+(Label *) GetLabel:(NSDictionary *) jsonData;

@end
