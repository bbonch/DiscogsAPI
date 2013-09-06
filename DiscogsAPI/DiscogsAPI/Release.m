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
    if (![self isNeededRelease:jsonData])
    {
        return nil;
    }
    
    Release *release = [Release new];
    
    release.identifier = (long)[jsonData objectForKey:@"id"];
    release.name = [jsonData objectForKey:@"title"];
    release.year = [jsonData objectForKey:@"year"];
    release.genre = [[jsonData objectForKey:@"genres"] objectAtIndex:0];
    release.labelName = [[[jsonData objectForKey:@"labels"] objectAtIndex:0] objectForKey:@"name"];
    if (release.labelName == nil)
    {
        release.labelName = @"unknown label";
    }
    release.artistName = [[[jsonData objectForKey:@"artists"] objectAtIndex:0] objectForKey:@"name"];
    if (release.artistName == nil)
    {
        release.artistName = @"unknown artist";
    }
    NSArray *videos = [jsonData objectForKey:@"videos"];
    
    if (videos == nil)
    {
        return nil;
    }
    
    NSMutableDictionary *releaseVideos = [[NSMutableDictionary alloc] initWithCapacity:videos.count];
    for (NSDictionary * video in videos) {
        [releaseVideos setObject:[video objectForKey:@"uri"] forKey:[video objectForKey:@"title"]];
    }
    release.tracks = releaseVideos;
    
    return release;
}

+(BOOL) isNeededRelease:(NSDictionary *) jsonData
{
    NSString * mainRelease = [jsonData objectForKey:@"main_release"];
    
    if (mainRelease != nil)
    {
        return YES;
    }
    
    return YES;
}

@end
