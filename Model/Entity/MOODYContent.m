//
//  MOODYContent.m
//  moody
//
//  Created by Ran Ma on 13-11-23.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYContent.h"

@implementation MOODYContent

- (id)initWithId:(int*)contentId_ dateCreated:(NSDate*)dateCreated_ image:(UIImage*)image_ text:(NSString*)text_ {
    
    if (self = [super init]) {
        [self setContentId:contentId_];
        [self setDateCreated:dateCreated_];
        [self setImage:image_];
        [self setText:text_];
    }
    return self;
}

@end
