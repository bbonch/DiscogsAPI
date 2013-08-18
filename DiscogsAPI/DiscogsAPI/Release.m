//
//  Release.m
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Release.h"

@implementation Release

+(Release *) GetRelease:(NSDictionary *)jsonData
{
    Release *release = [Release new];
    
    release.identifier = (long)[jsonData objectForKey:@"id"];
    release.name = [jsonData objectForKey:@"title"];
    release.year = [jsonData objectForKey:@"year"];
    NSArray *videos = [jsonData objectForKey:@"videos"];
    NSMutableDictionary *releaseVideos = [[NSMutableDictionary alloc] initWithCapacity:videos.count];
    for (NSDictionary * video in videos) {
        [releaseVideos setObject:[video objectForKey:@"title"] forKey:@"uri"];
    }
    release.tracks = releaseVideos;
    
    return release;
}

@end
