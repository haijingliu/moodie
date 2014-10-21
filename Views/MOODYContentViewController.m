//
//  MOODYContentViewController.m
//  moody
//
//  Created by Ran Ma on 13-11-23.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYContentViewController.h"
#import "MOODYMoodData.h"
#import "MOODYMoodDataWrapper.h"
#import "MOODYUtil.h"
#import "AFHTTPRequestOperationManager.h"

@interface MOODYContentViewController ()

@end

@implementation MOODYContentViewController

@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self imgView] setImage:[UIImage imageNamed:@"plus1.png"]];
    
    content = [[MOODYContent alloc] init];
    
    [self.reloadBtn addTarget:self action:@selector(reloadBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.facebookBtn addTarget:self action:@selector(facebookBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.twitterBtn addTarget:self action:@selector(twitterBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self reloadContent];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)reloadBtnTouch:(id)sender {
    [self reloadContent];
}

- (void)reloadContent {
    
    if (isReloading) {
        return;
    }
    
    MOODYMoodDataWrapper* data = [MOODYMoodData getDataWrapperWithDateRange:All];
    
    int moodIndexForRequest = [MOODYUtil computeMoodIndexForContentRequest:data];
    
    if (moodIndexForRequest == -1) {
        [self showEmptyData];
        return;
    }
    
    isReloading = true;
    [[self reloadBtn] setEnabled:NO];
    [[self reloadBtn] setTitle:@"loading" forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        //start fetch data
        NSURL *dataURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://echo.jsontest.com/key/value/one/%i", moodIndexForRequest]];
        NSURLRequest *dataRequest = [NSURLRequest requestWithURL:dataURL];
        AFHTTPRequestOperation *dataOperation = [[AFHTTPRequestOperation alloc]
                                                 initWithRequest:dataRequest];
        dataOperation.responseSerializer = [AFJSONResponseSerializer serializer];
        [dataOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response Text: %@", responseObject);
            [[self content] setText:responseObject];
            
            //start fetch image
            NSURL *imageURL = [NSURL URLWithString:@"http://d13yacurqjgara.cloudfront.net/users/93631/screenshots/1338387/holiday-vignette.jpg"];
            NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
            AFHTTPRequestOperation *imageOperation = [[AFHTTPRequestOperation alloc] initWithRequest:imageRequest];
            imageOperation.responseSerializer = [AFImageResponseSerializer serializer];
            [imageOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"Response Image: %@", responseObject);
                [[self imgView] setImage:responseObject];
                [[self content] setImage:responseObject];
                [self reloadFinished];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Image error: %@", error);
                [self reloadFinished];
            }];
            
            [imageOperation start];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Data error: %@", error);
            [self reloadFinished];
        }];
        [dataOperation start];
    });
}

- (void) reloadFinished {
    // back on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self reloadBtn] setTitle:@"reload" forState:UIControlStateNormal];
        [[self reloadBtn] setEnabled:YES];
        isReloading = false;
        NSLog(@"Reload finished");
    });
}

- (void)facebookBtnTouch:(id)sender {
    slComposeVC = [[SLComposeViewController alloc] init];
    slComposeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slComposeVC addImage:[[self content] image]];
    [self presentViewController:slComposeVC animated:YES completion:nil];
}

- (void)twitterBtnTouch:(id)sender {
    slComposeVC = [[SLComposeViewController alloc] init];
    slComposeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slComposeVC addImage:[[self content] image]];
    [self presentViewController:slComposeVC animated:YES completion:nil];
}

- (void)showEmptyData {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
