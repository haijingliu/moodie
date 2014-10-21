//
//  MOODYGlobal.h
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOODYMoodDataWrapper.h"

@interface MOODYGlobal : NSObject

@property (strong, nonatomic) MOODYMoodDataWrapper* moodDataCache;

+ (id)getInstance;

+ (NSArray *)moodNames;

+ (NSArray *)positiveMoodNames;

+ (NSArray *)negativeMoodNames;

+ (BOOL)isPositiveMood:(int)index_;

+ (BOOL)getMaxScore;

+ (BOOL)getMinScore;

+ (int)getLocalQuotesCount:(int)moodIndex;

@end
