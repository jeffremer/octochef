//
//  Branch.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Models.h"
#import "ObjectMapperDelegate.h"

@implementation Branch
@synthesize name;
@synthesize sha;

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
