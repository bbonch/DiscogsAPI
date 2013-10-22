//
//  Label.m
//  DiscogsAPI
//
//  Created by Admin on 7/18/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import "Label.h"

@implementation Label

+(Label *) GetLabel:(NSDictionary *) jsonData
{
    Label *label = [Label new];
    
    label.identifier = (long)[jsonData objectForKey:@"id"];
    label.name = [jsonData objectForKey:@"name"];
    label.profile = [jsonData objectForKey:@"profile"];
    label.releasesUrl = [jsonData objectForKey:@"releases_url"];
    
    NSArray *imageArray = [jsonData objectForKey:@"images"];
    label.images = [[NSMutableArray alloc] initWithCapacity:imageArray.count];
    
    for (NSDictionary *image in imageArray)
    {
        [label.images addObject:[image objectForKey:@"uri"]];
    }
    
    return label;
}

@end
