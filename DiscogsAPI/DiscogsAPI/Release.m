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
    Release *release = [Release new];
    
    release.identifier = (long)[jsonData objectForKey:@"id"];
    release.name = [jsonData objectForKey:@"title"];
    release.releaseUrl = [jsonData objectForKey:@"uri"];
    release.imageUrl = [[[jsonData objectForKey:@"images"] objectAtIndex:0] objectForKey:@"uri"];
    release.smallImageUrl = [[[jsonData objectForKey:@"images"] objectAtIndex:0] objectForKey:@"uri150"];
    
    release.year = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"year"]];
    if (release.year == nil || release.year.length == 0 || [release.year isEqualToString:@"0"])
    {
        release.year = @"unknown year";
    }
    
    NSArray *genres = [jsonData objectForKey:@"genres"];
    if (genres == nil || genres.count == 0)
    {
        release.genres = [[NSMutableArray alloc] initWithArray:@[@"unknown genre"]];
    }
    else
    {
        release.genres = [[NSMutableArray alloc] initWithCapacity:genres.count];
        for (NSString *genre in genres)
        {
            [release.genres addObject:genre];
        }
    }
    
    NSArray *styles = [jsonData objectForKey:@"styles"];
    if (styles == nil || styles.count == 0)
    {
        release.styles = [[NSMutableArray alloc] initWithArray:@[@"unknown style"]];
    }
    else
    {
        release.styles = [[NSMutableArray alloc] initWithCapacity:styles.count];
        for (NSString *style in styles)
        {
            [release.styles addObject:style];
        }
    }
    
    release.labelName = [[[jsonData objectForKey:@"labels"] objectAtIndex:0] objectForKey:@"name"];
    if (release.labelName == nil || release.labelName.length == 0)
    {
        release.labelName = @"unknown label";
    }
    
    release.artistName = [[[jsonData objectForKey:@"artists"] objectAtIndex:0] objectForKey:@"name"];
    if (release.artistName == nil || release.artistName.length == 0)
    {
        release.artistName = @"unknown artist";
    }
    
    release.country = [jsonData objectForKey:@"country"];
    if (release.country == nil)
    {
        release.country = @"unknown country";
    }
    
    release.tracks = [self getTracks:jsonData :release];
    release.formats = [self getTracks:jsonData];
    
    return release;
}

+(NSMutableArray *) getTracks:(NSDictionary *)jsonData :(Release *) release
{
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
            else
            {
                releaseTrack.artist = @"unknown artist";
            }
        }
        else
        {
            releaseTrack.artist = release.artistName;
        }
        
        [releaseTracks addObject:releaseTrack];
    }
    
    return releaseTracks;
}

+(NSMutableArray *) getTracks:(NSDictionary *) jsonData
{
    NSArray *formats = [jsonData objectForKey:@"formats"];
    
    if (formats == nil)
    {
        return nil;
    }
    
    NSMutableArray *formatDescriptions = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSDictionary *format in formats)
    {
        NSArray *descriptions = [format objectForKey:@"descriptions"];
        if (descriptions != nil)
        {
            for (NSString *description in descriptions)
            {
                [formatDescriptions addObject:description];
            }
        }
        
        NSString *text = [format objectForKey:@"text"];
        if (text != nil)
        {
            [formatDescriptions addObject:text];
        }
    }
    
    return formatDescriptions;
}

@end
