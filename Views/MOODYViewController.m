//
//  MOODYViewController.m
//  moody
//
//  Created by Ran Ma on 13-09-30.
//  Copyright (c) 2013 contextmix. All rights reserved.
//
#import "MOODYViewController.h"
#import "MOODYMoodData.h"

@interface MOODYViewController ()

@end

@implementation MOODYViewController

static const int NumberOfPages = 3;
static const int MoodSelectPageIndex = 0;
static const int ContentPageIndex = 1;
static const int DetailsPageIndex = 2;

@synthesize contentVC, moodSelectVC, detailsVC;

- (void)viewDidLoad
{
    pageControlBeingUsed = NO;
    
    prevPage = ContentPageIndex;
    curPage = ContentPageIndex;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * NumberOfPages, self.scrollView.frame.size.height);
    
    contentVC = [[MOODYContentViewController alloc] initWithNibName:@"MOODYContentViewController" bundle:nil];
    moodSelectVC = [[MOODYMoodSelectViewController alloc] initWithNibName:@"MOODYMoodSelectViewController" bundle:nil];
    detailsVC = [[MOODYDetailsViewController alloc] initWithNibName:@"MOODYDetailsViewController" bundle:nil];
    
    moodSelectVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    contentVC.view.frame = CGRectMake(self.view.frame.size.width * ContentPageIndex, 0, self.view.frame.size.width, self.view.frame.size.height);
    detailsVC.view.frame = CGRectMake(self.view.frame.size.width * DetailsPageIndex, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.scrollView addSubview:moodSelectVC.view];
    [self.scrollView addSubview:contentVC.view];
    [self.scrollView addSubview:detailsVC.view];
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * ContentPageIndex;
    [self.scrollView scrollRectToVisible:frame animated:NO];

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		CGFloat pageWidth = self.scrollView.frame.size.width;
		self->curPage = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (curPage != prevPage) {
        switch (curPage) {
            case MoodSelectPageIndex:
                break;
            case ContentPageIndex:
                [contentVC reloadContent];
                break;
            case DetailsPageIndex:
                [detailsVC loadData];
                break;
            default:
                break;
        }
    }
    NSLog(@"CUR_PAGE,PREV_PAGE/%i,%i", curPage, prevPage);
    prevPage = curPage;
	pageControlBeingUsed = NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
    self.moodSelectVC = nil;
    self.detailsVC = nil;
}


@end
