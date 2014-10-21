//
//  MOODYMoodDataWrapper.m
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYMoodDataWrapper.h"
#import "MOODYGlobal.h"
#import "MOODYMoodData.h"

@implementation MOODYMoodDataWrapper

@synthesize moodData,moodCounts,positiveTotal,negativeTotal;

- (id)initWithData:(NSMutableArray*)moodData_ counts:(NSMutableArray*)moodCounts_ positiveTotal:(int)positiveTotal_ negativeTotal:(int)negativeTotal_ {
    
    if (self = [super init]) {
        moodData = moodData_;
        moodCounts = moodCounts_;
        positiveTotal = positiveTotal_;
        negativeTotal = negativeTotal_;
    }
    return self;
}

- (void)setData:(MOODYMoodDataWrapper*)dataWrapper_ {
    @synchronized(self) {
        moodData = dataWrapper_.moodData;
        moodCounts = dataWrapper_.moodCounts;
        positiveTotal = dataWrapper_.positiveTotal;
        negativeTotal = dataWrapper_.negativeTotal;
    }
}

- (void)addData:(MOODYMoodData*)data_{
    @synchronized(self) {
        if (!data_)
            return;
        int mIndex = [data_.moodIndex intValue];
        if (mIndex >= 0 && mIndex < moodCounts.count) {
            [moodCounts setObject:[NSNumber numberWithInteger:1 + [[moodCounts objectAtIndex:mIndex] intValue]] atIndexedSubscript:mIndex];
            if ([MOODYGlobal isPositiveMood:mIndex]) {
                ++positiveTotal;
            } else {
                ++negativeTotal;
            }
        }
    }
}

- (int) total {
    if (moodData)
        return moodData.count;
    else
        return 0;
}

@end
