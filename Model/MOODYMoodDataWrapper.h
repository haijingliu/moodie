//
//  MOODYMoodDataWrapper.h
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOODYMoodData.h"

@interface MOODYMoodDataWrapper : NSObject

@property (readonly, strong, nonatomic) NSMutableArray* moodData;
@property (readonly, strong, nonatomic) NSMutableArray* moodCounts;
@property (readonly, assign, nonatomic) int positiveTotal;
@property (readonly, assign, nonatomic) int negativeTotal;

- (id)initWithData:(NSMutableArray*)moodData_ counts:(NSMutableArray*)moodCounts_ positiveTotal:(int)positiveTotal_ negativeTotal:(int)negativeTotal_;

- (void)addData:(MOODYMoodData*)data_;

- (void)setData:(MOODYMoodDataWrapper*)dataWrapper_;

- (int)total;

@end
