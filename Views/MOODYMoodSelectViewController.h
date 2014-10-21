//
//  MOODYMoodSelectViewController.h
//  moody
//
//  Created by Ran Ma on 13-10-01.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOODYMoodSelectViewController : UIViewController <UIScrollViewDelegate> {
    UIImageView *notifView;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *selectView;

@end
