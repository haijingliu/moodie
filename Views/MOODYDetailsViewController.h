//
//  MOODYDetailsViewController.h
//  moody
//
//  Created by Ran Ma on 13-10-05.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOODYMoodData.h"
#import "MOODYMoodDataWrapper.h"
#import "UICountingLabel.h"

@interface MOODYDetailsViewController : UIViewController

@property (assign, nonatomic) DateRange selectedDateRange;

@property (strong, nonatomic) MOODYMoodDataWrapper *moodDataWrapper;

@property (strong, nonatomic) IBOutlet UIScrollView *moodScrollView;
@property (strong, nonatomic) IBOutlet UIView *moodScoreView;
@property (strong, nonatomic) IBOutlet UICountingLabel *moodScore;

@property (strong, nonatomic) IBOutlet UISegmentedControl *dateRangePicker;

- (void)loadData;

+ (void)notifyDataChanged;
@end
