//
//  MOODYContentViewController.h
//  moody
//
//  Created by Ran Ma on 13-11-23.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "MOODYContent.h"

@interface MOODYContentViewController : UIViewController {
    SLComposeViewController *slComposeVC;
    BOOL isReloading;
}
@property (strong, atomic) MOODYContent *content;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIButton *reloadBtn;

@property (strong, nonatomic) IBOutlet UIButton *facebookBtn;
@property (strong, nonatomic) IBOutlet UIButton *twitterBtn;

- (void)reloadContent;
@end
