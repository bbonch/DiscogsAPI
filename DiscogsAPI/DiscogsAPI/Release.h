//
//  Release.h
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Release : NSObject

@property long identifier;
@property NSString *name;
@property NSMutableDictionary *tracks;
@property NSString *year;
@property NSString *label;
@property NSString *artist;
@property NSString *labelName;
@property NSString *artistName;
@property NSString *genre;

+(Release *) GetRelease:(NSDictionary *)jsonData;

@end
