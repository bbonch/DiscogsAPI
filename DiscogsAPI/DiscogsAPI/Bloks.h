//
//  Bloks.h
//  DiscogsAPI
//
//  Created by Admin on 10/10/13.
//  Copyright (c) 2013 bbonch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^ HandleJSONBlock)(NSDictionary *jsonData);

@interface Blocks : NSObject

+(id) handleJSON:(NSMutableData *) jsonData withBlock:(HandleJSONBlock) block;

@end
