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
@property NSDictionary *tracks;

+(Release *) GetRelease:(NSDictionary *)jsonData;

@end
