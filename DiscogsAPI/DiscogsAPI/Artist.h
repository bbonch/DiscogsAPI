//
//  Artist.h
//  DiscogsAPI
//
//  Created by Admin on 7/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property long identifier;
@property NSString *name;
@property NSString *profile;
@property NSString *releasesUrl;

+(Artist *) GetArtist:(NSDictionary *) jsonData;
@end
