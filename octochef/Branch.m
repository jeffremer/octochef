//
//  Branch.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Models.h"
#import "ObjectMapperDelegate.h"
#import "UserSingleton.h"

@implementation Branch
@synthesize name;
@synthesize sha;

+(void) createBranchDirectory:(NSString *)repo andSha:(NSString *)sha {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * path = [[[[paths objectAtIndex:0] stringByAppendingPathComponent:[UserSingleton sharedUser].username]
                       stringByAppendingPathComponent:repo]
                       stringByAppendingPathComponent:sha];
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

-(void) fetchTreeWithDelegate:(ObjectMapperDelegate*) omDelegate andRepo:(NSString *)repo {
    NSLog(@"Fetching tree from server");
    RKObjectMapping* treeMapping = [RKObjectMapping mappingForClass:[Tree class]];
    
    RKObjectMapping* leafMapping = [RKObjectMapping mappingForClass:[Leaf class]];
    
    NSString *resource = [NSString stringWithFormat:@"/repos/%@/%@/git/trees/%@?recursive=1", omDelegate.username, repo, self.sha]; 
    //@"/repos/smithclay/lthmobile/git/trees/790f0f55353ded146de545dc5ff78a9dffa5929e?recursive=1"
    [leafMapping mapAttributes:@"path", @"sha", @"size", nil];
    [treeMapping hasMany:@"tree" withObjectMapping:leafMapping];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath: resource
                         objectMapping:treeMapping delegate:omDelegate];
}

@end
