//
//  Tree.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Leaf.h"
#import "ObjectMapperDelegate.h"
#import "UserSingleton.h"

@implementation Leaf
@synthesize path;
@synthesize size;
@synthesize sha;
+(void) fetchBlobWithDelegate:(ObjectMapperDelegate*) omDelegate {
    RKObjectMapping* blobMapping = [RKObjectMapping mappingForClass:[Blob class]];
    
    NSString *resource = [NSString stringWithFormat:@"/repos/%@/%@/git/blobs/%@", [UserSingleton sharedUser].username,
                          omDelegate.currentRepository, omDelegate.currentBlob]; 
    // @"/repos/smithclay/lthmobile/git/blobs/8c1e42c7db7c7c6e069a438abe0db4389b9879ca"
    [blobMapping mapAttributes:@"content", @"encoding", nil];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resource
                                                 objectMapping:blobMapping  delegate:omDelegate];
}
@end
