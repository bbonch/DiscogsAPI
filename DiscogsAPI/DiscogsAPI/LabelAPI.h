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

+(Label *) GetLabelById:(long) labelId;
+(Label *) GetLabelByUrl:(NSString *) labelUrl;
+(NSMutableArray *) GetReleasesForLabel:(NSString *) releasesUrl withPagination:(Pagination *)pagination;

@end