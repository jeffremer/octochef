//
//  Repository.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Repository.h"


@implementation Repository
@synthesize name;
@synthesize description;
@synthesize created_at;
@synthesize html_url;

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

/*-(void) archiveToFile: (NSString*) path {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData: data];
    [archiver encodeObject: self forKey: @"repository"];
    [archiver finishEncoding];
    [archiver release];
    [data writeToFile: path atomically: YES];
    [data release];
}

+(Repository*) newFromFile: (NSString*) path {
    NSData *data = [[NSData alloc] initWithContentsOfFile: path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];
    Repository *myArchive = [unarchiver decodeObjectForKey: @"repository"];
    [unarchiver finishDecoding];
    
    if (myArchive) {
        [myArchive retain];
    } 
    [unarchiver release];
    [data release];
    return myArchive;
}*/
@end
