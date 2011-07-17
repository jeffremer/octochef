//
//  UserSingleton.m
//  octochef
//
//  Created by Clay Smith on 7/17/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "UserSingleton.h"

@implementation UserSingleton
@synthesize username;
static UserSingleton *sharedSingleton;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedSingleton = [[UserSingleton alloc] init];
    }
}

+ (UserSingleton *)sharedUser {
    return sharedSingleton;
}
@end
