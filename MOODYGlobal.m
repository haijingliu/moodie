//
//  MOODYGlobal.m
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYGlobal.h"

@implementation MOODYGlobal

static MOODYGlobal *instance = nil;

static NSArray *moodNames, *positiveMoodNames, *negativeMoodNames;

static int localQuotesCount[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

// CONFIG: min/max score
static int maxScore = 100;
static int minScore = 50;

@synthesize moodDataCache;

+ (id)getInstance {
    @synchronized(self) {
        if(instance == nil)
            instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

+ (void)initialize {
    [super initialize];
    
    // CONFIG: display sequence and mood index
    moodNames = @[@"Excited", @"Relaxed", @"Sexy", @"Energetic", @"Romantic", @"Confused", @"Nostalgic", @"Angry", @"Bored", @"Afraid", @"Tired", @"Sick", @"Happy", @"Productive", @"Sad"];
    
    //CONFIG: positive set
    positiveMoodNames = @[@"Excited", @"Relaxed", @"Sexy", @"Energetic", @"Romantic", @"Happy", @"Productive"];
    
    //CONFIG: negative set
    negativeMoodNames = @[@"Confused", @"Nostalgic", @"Angry", @"Bored", @"Afraid", @"Tired", @"Sick", @"Sad"] ;
}


- (id)init {
    if (self = [super init]) {
        moodDataCache = nil;
    }
    return self;
}

+ (NSArray *)moodNames
{
    return moodNames;
}

+ (NSArray *)positiveMoodNames
{
    return positiveMoodNames;
}

+ (NSArray *)negativeMoodNames
{
    return negativeMoodNames;
}

+ (BOOL)isPositiveMood:(int)index_ {

    NSUInteger idx = [positiveMoodNames indexOfObject:[moodNames objectAtIndex:index_]];
    return idx != NSNotFound;
}

+ (BOOL)getMaxScore{
    return maxScore;
}

+ (BOOL)getMinScore{
    return minScore;
}

+ (int)getLocalQuotesCount:(int)moodIndex {
    if (moodIndex > 0 && moodIndex < moodNames.count)
        return localQuotesCount[moodIndex];
    return 0;
}

@end
