//
//  LabelAPI.h
//  DiscogsAPI
//
//  Created by Admin on 7/18/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Label.h"
#import "Pagination.h"

@interface LabelAPI : NSObject

+(Label *) getLabelById:(long) labelId;
+(Label *) getLabelByUrl:(NSString *) labelUrl;
+(NSMutableArray *) getReleasesForLabel:(NSString *) releasesUrl withPagination:(Pagination *)pagination;

@end
