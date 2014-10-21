//
//  MOODYMoodSelectViewController.m
//  moody
//
//  Created by Ran Ma on 13-10-01.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYMoodSelectViewController.h"
#import "MOODYDetailsViewController.h"
#import "MOODYMoodData.h"
#import "MOODYGlobal.h"

@interface MOODYMoodSelectViewController ()

@end

@implementation MOODYMoodSelectViewController

static int moodButtonSize = 107;
static int moodButtonColumns = 3;

@synthesize selectView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int row = 0, column = 0, total = [[MOODYGlobal moodNames] count];
    
    [self.selectView setContentSize:CGSizeMake(320, moodButtonSize*(total/moodButtonColumns))];
    
    notifView = [[UIImageView alloc] initWithFrame: CGRectMake ( 0, 0, moodButtonSize, moodButtonSize)];

    // center the notification
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    notifView.center = CGPointMake(screenRect.size.width / 2, screenRect.size.height / 2);
    [[self view] addSubview:notifView];
    
    for(int i = 0; i < total; i++){
        
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(column * moodButtonSize, row * moodButtonSize, moodButtonSize, moodButtonSize)];
        
        UIImage *buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[MOODYGlobal moodNames] objectAtIndex:i]]];
        //UIImage *buttonImage = [UIImage imageNamed:@"Bored.png"];
        
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        
        //TODO testing
        [button setTitle:NSLocalizedString([[MOODYGlobal moodNames] objectAtIndex:i], nil) forState:UIControlStateNormal];
        [button setTitle:@"Clicked" forState:UIControlStateHighlighted];
        [button setBackgroundColor:[UIColor grayColor]];
        
        
        [self.selectView addSubview:button];
        
        if((i + 1) % moodButtonColumns == 0){
            ++row;
            column = 0;
        } else {
            ++column;
        }
    }
}

- (void)moodButtonClick:(id)sender {
    
    int tag = [(UIButton *)sender tag];
    
    BOOL success = [MOODYMoodData addMoodWithIndex:[[NSNumber alloc] initWithInt:tag] date:[[NSDate alloc] init] notes:nil];
    
    if (success) {
        [self notifyDataChanged];
        
        UIImage *notifImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[MOODYGlobal moodNames] objectAtIndex:tag]]];
        
        [notifView setImage:notifImg];
        [notifView setHidden:NO];
        [notifView setAlpha:0.3];
        
        [UIView animateWithDuration:0.6 animations:^() {
            notifView.alpha = 0.75;
            notifView.transform = CGAffineTransformMakeScale(2, 2);
        } completion:^(BOOL finished) {
            [notifView setAlpha:0.0];
            notifView.transform = CGAffineTransformMakeScale(1, 1);
            [notifView setHidden:YES];
        }];
    } else {
        //TODO error
    }
}

- (void)notifyDataChanged {
    [MOODYDetailsViewController notifyDataChanged];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSelectView:nil];
    [super viewDidUnload];
}
@end
