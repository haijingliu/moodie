//
//  MOODYDetailsViewController.m
//  moody
//
//  Created by Ran Ma on 13-10-05.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYDetailsViewController.h"
#import "MOODYGlobal.h"
#import "MOODYUtil.h"
#import "MOODYMoodData.h"

@interface MOODYDetailsViewController ()

@end

@implementation MOODYDetailsViewController

static int moodImagePadding = 5;

static BOOL dataChanged = YES;

@synthesize selectedDateRange,moodDataWrapper;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setSelectedDateRange:Month];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.dateRangePicker addTarget:self action:@selector(switchDateRange:) forControlEvents:UIControlEventValueChanged];
    
    [self.moodScore setMethod:UILabelCountingMethodEaseIn];
    [self.moodScore setFormat:@"%i"];
}

+ (void)notifyDataChanged{
    dataChanged = true;
}

- (void)loadData {
    
    if (!dataChanged) {
        return;
    }
    
    dataChanged = NO;
    
    moodDataWrapper = [MOODYMoodData getDataWrapperWithDateRange:selectedDateRange];
    
    [self buildMoodDetails];
    
    int score = [MOODYUtil computeMoodScore:moodDataWrapper];
    
    if (score == -1) {
        [self showEmptyData];
    } else {
        [self showScore:score];
    }
    CGRect frame = self.moodScrollView.frame;
    frame.origin.x = 0;
    [self.moodScrollView scrollRectToVisible:frame animated:YES];
}

- (void)buildMoodDetails {
    //reset views
    [self.moodScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //moodScrollView
    int total = [[MOODYGlobal moodNames] count];
    
    int moodButtonSize = 200 - 2 * moodImagePadding;
    
    [self.moodScrollView setContentSize:CGSizeMake(moodButtonSize * total + moodImagePadding * (total + 1), moodButtonSize)];
    
    //sort (rewrite this later)
    NSMutableArray *sortedMoodIndex = [[NSMutableArray alloc] init];
    NSMutableArray *sortedCount = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < total; i++){
        [sortedMoodIndex setObject:[NSNumber numberWithInt:i] atIndexedSubscript:i];
        [sortedCount setObject:[[moodDataWrapper moodCounts] objectAtIndex:i] atIndexedSubscript:i];
    }
    [sortedMoodIndex sortUsingComparator: ^(id a, id b) {
        int aint = [a intValue];
        int bint = [b intValue];
        NSNumber *aNum = [[moodDataWrapper moodCounts] objectAtIndex:aint];
        NSNumber *bNum = [[moodDataWrapper moodCounts] objectAtIndex:bint];
        
        return [bNum compare:aNum];
    }];
    [sortedCount sortUsingComparator: ^(id a, id b) {
        return [b compare:a];
    }];

    
    for(int i = 0; i < total; i++){
        
        int moodButtonX = i * moodButtonSize + (i + 1) * moodImagePadding;
        
        int sortedIndex = [[sortedMoodIndex objectAtIndex:i] intValue];
        
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame: CGRectMake(moodButtonX, moodImagePadding, moodButtonSize, moodButtonSize)];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[MOODYGlobal moodNames] objectAtIndex:sortedIndex]]];
        
        [bgImgView setImage:image];
        UIView *overlay = [[UIView alloc] initWithFrame: CGRectMake(moodButtonX, moodImagePadding, moodButtonSize, moodButtonSize)];
        [overlay setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3f]];
        
        UILabel *countLabel = [[UILabel alloc] init];
        [countLabel setText:[NSString stringWithFormat:@"%@",[[moodDataWrapper moodCounts] objectAtIndex:sortedIndex]]];
        [countLabel setBackgroundColor:[UIColor clearColor]];
        [countLabel setFont:[UIFont fontWithName:@"Helvetica" size:75]];
        [countLabel setTextColor:[UIColor blackColor]];
        [countLabel sizeToFit];
        [countLabel setCenter:CGPointMake(moodButtonSize/2, moodButtonSize/2)];
        [overlay addSubview:countLabel];
        
        [self.moodScrollView addSubview:bgImgView];
        [self.moodScrollView addSubview:overlay];
    }
}


- (void)showScore:(int)score_{
    //TODO counting and colors
    [self.moodScore countFrom:(int)0 to:score_ withDuration:0.5f];
}

- (void)showEmptyData {
    #ifdef DEBUG
        NSLog(@"SHOW EMPTY DATA");
    #endif
}

- (void)switchDateRange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*) sender;
    switch ([segmentedControl selectedSegmentIndex]) {
        case Week:
            selectedDateRange = Week;
            break;
        case Month:
            selectedDateRange = Month;
            break;
        case Year:
            selectedDateRange = Year;
            break;
        case All:
            selectedDateRange = All;
            break;
        default:
            selectedDateRange = Day;
            break;
    }
    [MOODYDetailsViewController notifyDataChanged];
    [self loadData];
}

- (void)moodButtonClick:(id)sender {
    
    int tag = [(UIButton *)sender tag];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[MOODYGlobal moodNames] objectAtIndex:[(UIButton *)sender tag]] message:[[[moodDataWrapper moodCounts] objectAtIndex:tag] stringValue] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMoodScrollView:nil];
    [self setMoodScoreView:nil];
    [self setDateRangePicker:nil];
    [self setMoodScore:nil];
    [super viewDidUnload];
}
@end
