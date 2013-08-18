//
//  ReleaseAPI.h
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Release.h"

@interface ReleaseAPI : NSObject

+(Release *) GetReleaseById:(long) releaseId;
+(Release *) GetReleaseByUrl:(NSString *) releaseUrl;
+(NSMutableArray *) GetReleasesByUrl:(NSString *) releasesUrl;

@end
