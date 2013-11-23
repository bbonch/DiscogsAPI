//
//  ReleaseAPI.h
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Release.h"
#import "QueryResult.h"

@interface ReleaseAPI : NSObject

+(Release *) getReleaseById:(long) releaseId;
+(Release *) getReleaseByUrl:(NSString *) releaseUrl;
+(QueryResult *) getReleasesByUrl:(NSString *) releasesUrl withPagination:(Pagination *) pagination;

@end
