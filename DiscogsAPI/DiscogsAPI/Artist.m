//
//  Artist.m
//  DiscogsAPI
//
//  Created by Admin on 7/24/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Artist.h"

@implementation Artist

+(Artist *) getArtist:(NSDictionary *) jsonData
{
    Artist *artist = [Artist new];
    
    artist.identifier = (long)[jsonData objectForKey:@"id"];
    artist.name = [jsonData objectForKey:@"name"];
    artist.profile = [jsonData objectForKey:@"profile"];
    artist.releasesUrl = [jsonData objectForKey:@"releases_url"];
    
    NSArray *imageArray = [jsonData objectForKey:@"images"];
    artist.images = [[NSMutableArray alloc] initWithCapacity:imageArray.count];
    
    for (NSDictionary *image in imageArray)
    {
        [artist.images addObject:[image objectForKey:@"uri"]];
    }
    
    return artist;
}

@end
