//
//  ArtistAPI.h
//  DiscogsAPI
//
//  Created by Admin on 7/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"
#import "Pagination.h"

@interface ArtistAPI : NSObject

+(Artist *) GetArtistById:(long) artistId;
+(Artist *) GetArtistByUrl:(NSString *) artistUrl;
+(NSMutableArray *) GetReleasesForArtist:(NSString *) releasesUrl withPagination:(Pagination *) pagination;

@end
