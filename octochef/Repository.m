//
//  Repository.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Repository.h"
#import "ObjectMapperDelegate.h"

@implementation Repository
@synthesize name;
@synthesize description;
@synthesize created_at;
@synthesize html_url;

- (void)fetchBranchesWithDelegate:(ObjectMapperDelegate *)omDelegate {
    NSLog(@"Fetching branches from server");
    
    RKObjectMapping* branchMapping = [RKObjectMapping mappingForClass:[Branch class]];
    
    NSString *resource = [NSString stringWithFormat:@"/repos/%@/%@/branches", omDelegate.username, self.name]; 

    [branchMapping mapAttributes:@"name", nil];
    [branchMapping mapKeyPathsToAttributes:@"commit.sha", @"sha",  nil];
    
    [[RKObjectManager sharedManager]
     loadObjectsAtResourcePath:resource objectMapping:branchMapping delegate:omDelegate];
}

// Encode an object for an archive
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:description forKey:@"description"];
    [coder encodeObject:html_url forKey:@"html_url"];
    [coder encodeObject:created_at forKey:@"created_at"];

}
// Decode an object from an archive
- (id)initWithCoder:(NSCoder *)coder
{
    if ((self=[super init])) {
        name = [[coder decodeObjectForKey:@"name"] retain];
        description  = [[coder decodeObjectForKey:@"description"] retain];
        html_url  = [[coder decodeObjectForKey:@"html_url"] retain];
        created_at  = [[coder decodeObjectForKey:@"html_url"] retain];
    }
    return self;
}
@end
