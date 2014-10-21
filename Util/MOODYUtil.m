//
//  MOODYUtil.m
//  moody
//
//  Created by Ran Ma on 12/8/2013.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYUtil.h"
#import "MOODYGlobal.h"
#import "MOODYMoodDataWrapper.h"

@implementation MOODYUtil


+ (int)computeMoodScore:(MOODYMoodDataWrapper*)data_ {
    if (!data_ || data_.total <= 0) {
        return -1;
    }
    int max = [MOODYGlobal getMaxScore];
    int min = [MOODYGlobal getMinScore];
    
    int score = min + (max - min)/2;
    if (data_ && data_.total > 0) {
        score = (max - min) * ((double)data_.positiveTotal/data_.total) + (min);
    }
    
#ifdef DEBUG
    NSLog(@"------ Mood score:%i, positives:%i, total:%i ------", score, data_.positiveTotal, data_.total);
#endif
    return score;
}

+ (int)computeMoodIndexForContentRequest:(MOODYMoodDataWrapper*)data_ {
    if (!data_ || data_.total <= 0) {
        return -1;
    }
    int randomVal = arc4random() % 1000 + 1;
    int sum = 0;
    int i = 0;
    
    for (; i < [[MOODYGlobal moodNames] count]; ++i) {
        int weight = (double)[[data_.moodCounts objectAtIndex:i] intValue] / data_.total * 1000;
        sum += weight;
        
#ifdef DEBUG
        NSLog(@"Analyze(rand:%i) mood:%@, count:%i, total:%i, positives:%i, weight:%i, sum:%i", randomVal, [[MOODYGlobal moodNames] objectAtIndex:i], [[data_.moodCounts objectAtIndex:i] intValue], data_.total, data_.positiveTotal, weight, sum);
#endif
        
        if (sum >= randomVal) {
            return i;
        }
    }
    //maybe some rounding error
    return i;
}

@end
