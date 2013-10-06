//
//  Release.m
//  DiscogsAPI
//
//  Created by Денис on 7/27/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Release.h"
#import "ReleaseTrack.h"

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
    if (release.year == nil)
    {
        release.year = @"unknown year";
    }
    release.genre = [[jsonData objectForKey:@"genres"] objectAtIndex:0];
    release.style = [[jsonData objectForKey:@"styles"] objectAtIndex:0];
    release.imageUrl = [[[jsonData objectForKey:@"images"] objectAtIndex:0] objectForKey:@"uri150"];
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
    NSArray *tracks = [jsonData objectForKey:@"tracklist"];
    
    if (tracks == nil)
    {
        return nil;
    }
    
    NSMutableArray *releaseTracks = [[NSMutableArray alloc] initWithCapacity:tracks.count];
    for (NSDictionary * track in tracks)
    {
        ReleaseTrack * releaseTrack = [ReleaseTrack new];
        releaseTrack.duration = [track objectForKey:@"duration"];
        releaseTrack.title = [track objectForKey:@"title"];
        
        if ([[release.artistName lowercaseString]  isEqual: @"various"])
        {
            NSArray *artists = [track objectForKey:@"artists"];
            if (artists != nil)
            {
                releaseTrack.artist = [[artists objectAtIndex:0] objectForKey:@"name"];
            }
        }
        else
        {
            releaseTrack.artist = release.artistName;
        }
        
        [releaseTracks addObject:releaseTrack];
    }
    release.tracks = releaseTracks;
    
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
