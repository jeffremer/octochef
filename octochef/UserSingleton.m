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

+ (void) createUserDirectory: (NSString *) user {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * path = [[paths objectAtIndex:0] stringByAppendingPathComponent:user];
	NSError *error;
	if (![[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		if (![[NSFileManager defaultManager] createDirectoryAtPath:path
									   withIntermediateDirectories:NO
														attributes:nil
															 error:&error])
		{
			NSLog(@"Create directory error: %@", error);
		}
	}
}

@end
