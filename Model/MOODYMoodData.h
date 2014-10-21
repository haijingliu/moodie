//
//  MOODYMoodData.h
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Day, Week, Month, Year, All
} DateRange;

@class MOODYMoodDataWrapper;

@interface MOODYMoodData : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber* moodIndex;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSString* notes;

- (id)initWithMoodIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_ notes:(NSString*)notes_;

- (id)initWithMoodIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_;

+ (BOOL)addMoodWithIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_ notes:(NSString*)notes_;

+ (BOOL)resetAllData;

+ (NSMutableArray*) getMoodDataWithRange:(DateRange)range_;

+ (MOODYMoodDataWrapper*)getDataWrapperWithDateRange:(DateRange)range_;

+ (MOODYMoodDataWrapper*)getDataWrapperWithMoodData:(NSMutableArray*)moodData_;

@end
