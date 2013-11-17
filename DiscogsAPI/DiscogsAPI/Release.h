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
@property NSMutableArray *tracks;
@property NSMutableArray *formats;
@property NSString *year;
@property NSString *label;
@property NSString *artist;
@property NSString *labelName;
@property NSString *artistName;
@property NSMutableArray *genres;
@property NSMutableArray *styles;
@property NSString *imageUrl;
@property NSString *smallImageUrl;
@property NSString *releaseUrl;
@property NSString *country;

+(Release *) GetRelease:(NSDictionary *)jsonData;

@end
