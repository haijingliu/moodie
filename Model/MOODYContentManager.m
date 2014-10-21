//
//  MOODYContentManager.m
//  moody
//
//  Created by Ran Ma on 11/30/2013.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYContentManager.h"

@implementation MOODYContentManager

static MOODYContentManager *instance = nil;

+ (id)getInstance {
    @synchronized(self) {
        if(instance == nil)
            instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

@end
