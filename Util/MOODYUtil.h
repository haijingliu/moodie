//
//  MOODYUtil.h
//  moody
//
//  Created by Ran Ma on 12/8/2013.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOODYMoodDataWrapper.h"

@interface MOODYUtil : NSObject

+ (int)computeMoodScore:(MOODYMoodDataWrapper*)data_;

+ (int)computeMoodIndexForContentRequest:(MOODYMoodDataWrapper*)data_;
    
@end
