//
//  MOODYContent.h
//  moody
//
//  Created by Ran Ma on 13-11-23.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Tip, Quote, Ad, Music, Image
} ContentType;

@interface MOODYContent : NSObject

@property (assign, nonatomic) int* contentId;
@property (strong, nonatomic) NSDate* dateCreated;
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSString* text;

@end
