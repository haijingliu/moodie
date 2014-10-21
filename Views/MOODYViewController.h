//
//  MOODYViewController.h
//  moody
//
//  Created by Ran Ma on 13-09-30.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOODYContentViewController.h"
#import "MOODYMoodSelectViewController.h"
#import "MOODYDetailsViewController.h"

@interface MOODYViewController : UIViewController <UIScrollViewDelegate> {
	
	BOOL pageControlBeingUsed;
    int prevPage, curPage;
}

@property (strong, nonatomic) IBOutlet UIScrollView* scrollView;

@property (strong, nonatomic) MOODYContentViewController* contentVC;
@property (strong, nonatomic) MOODYMoodSelectViewController* moodSelectVC;
@property (strong, nonatomic) MOODYDetailsViewController* detailsVC;

@end
