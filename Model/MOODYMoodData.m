//
//  MOODYMoodData.m
//  moody
//
//  Created by Ran Ma on 13-10-09.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYMoodData.h"
#import "MOODYMoodDataWrapper.h"
#import "MOODYGlobal.h"

@implementation MOODYMoodData

static NSString *MoodDataIndex = @"MOODYMoodDataIndex";
static NSString *MoodDataDate = @"MOODYMoodDataDate";
static NSString *MoodDataNotes = @"MOODYMoodDataNotes";

static NSString *fileName = @"MOODYMoodData";

@synthesize moodIndex,date,notes;

- (id)initWithMoodIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_ notes:(NSString*)notes_ {
    
    if (self = [super init]) {
        [self setMoodIndex:moodIndex_];
        [self setDate:date_];
        [self setNotes:notes_];
    }
    return self;
}

- (id)initWithMoodIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_ {
    
    return [self initWithMoodIndex:moodIndex_ date:date_ notes:nil];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.moodIndex forKey:MoodDataIndex];
    [aCoder encodeObject:self.date forKey:MoodDataDate];
    [aCoder encodeObject:self.notes forKey:MoodDataNotes];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super init])) {
        
        [self setMoodIndex:[aDecoder decodeObjectForKey:MoodDataIndex]];
        [self setDate:[aDecoder decodeObjectForKey:MoodDataDate]];
        [self setNotes:[aDecoder decodeObjectForKey:MoodDataNotes]];
    }
    return self;
}

+ (BOOL)addMoodWithIndex:(NSNumber*)moodIndex_ date:(NSDate*)date_ notes:(NSString*)notes_ {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:fileName];
    
    NSMutableArray *moods = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!moods) {
        moods = [[NSMutableArray alloc] init];
    }
    
    MOODYMoodData *data = [[MOODYMoodData alloc] initWithMoodIndex:moodIndex_ date:date_ notes:notes_];
    [moods addObject:data];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:moods toFile:filePath] && [[NSFileManager defaultManager] fileExistsAtPath: filePath];
    
    if (success) {
        MOODYMoodDataWrapper *wrapper = [self getDataWrapperWithDateRange:All];
        [wrapper addData:data];
    }
    
    return success;
}

+ (NSMutableArray*) getMoodDataWithRange:(DateRange)range_ {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:fileName];
    
    NSMutableArray *moods = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSDate *dateLimit = [[NSDate alloc] init];
    int secondsOffset = 0;
    bool noDateLimit = NO;
    NSMutableArray *moodData = [[NSMutableArray alloc] init];
    
    if (moods) {
        switch (range_) {
            case Day:
                secondsOffset = 1*24*60*60;
                break;
            case Week:
                secondsOffset = 7*24*60*60;
                break;
            case Month:
                secondsOffset = 30*24*60*60;
                break;
            case Year:
                secondsOffset = 365*24*60*60;
                break;
            case All:
                noDateLimit = YES;
                break;
            default:
                secondsOffset = 1*24*60*60;
                break;
        }
        
        dateLimit = [dateLimit dateByAddingTimeInterval:-secondsOffset];
        
        for (int i = moods.count - 1; i >= 0; --i) {
            if (noDateLimit || [dateLimit compare:[moods[i] date]] != NSOrderedDescending) {
                [moodData addObject:moods[i]];
            }
        }
    }
    
    return moodData;
}

+ (MOODYMoodDataWrapper*)getDataWrapperWithDateRange:(DateRange)range_ {
    if (range_ == All) {
        MOODYMoodDataWrapper *wrapper = [[MOODYGlobal getInstance] moodDataCache];
        
        // create new cache if cache doesn't exist otherwise return cache data
        if (wrapper != nil) {
            return wrapper;
        } else {
            wrapper = [self getDataWrapperWithMoodData:[self getMoodDataWithRange:All]];
            [[MOODYGlobal getInstance] setMoodDataCache:wrapper];
        }
        
        return wrapper;
    }
    return [self getDataWrapperWithMoodData:[self getMoodDataWithRange:range_]];
}

+ (MOODYMoodDataWrapper*)getDataWrapperWithMoodData:(NSMutableArray*)moodData_ {

    int capacity = [[MOODYGlobal moodNames] count];
    
    int positiveTotal = 0;
    int negativeTotal = 0;
    
    NSMutableArray *moodCounts = [[NSMutableArray alloc] initWithCapacity:capacity];
    
    for (int mIndex = 0; mIndex < capacity; ++mIndex) {
        [moodCounts setObject:[NSNumber numberWithInteger:0] atIndexedSubscript:mIndex];
    }
    
    if (moodData_) {
        for (int i = moodData_.count - 1; i >= 0; --i) {
            int mIndex = [[moodData_[i] moodIndex] intValue];
            [moodCounts setObject:[NSNumber numberWithInteger:1 + [[moodCounts objectAtIndex:mIndex] intValue]] atIndexedSubscript:mIndex];
            if ([MOODYGlobal isPositiveMood:mIndex]) {
                ++positiveTotal;
            } else {
                ++negativeTotal;
            }
        }
    }
    MOODYMoodDataWrapper *wrapper = [[MOODYMoodDataWrapper alloc] initWithData:moodData_ counts:moodCounts positiveTotal:positiveTotal negativeTotal:negativeTotal ];
    
    return wrapper;
}

+ (BOOL)resetAllData {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:filePath error:NULL] && ![[NSFileManager defaultManager] fileExistsAtPath: filePath];
    
    if (success) {
        [[MOODYGlobal getInstance] setMoodDataCache:nil];
    }
    
    return success;
}

+ (NSString*)fileName {
    return fileName;
}

@end
