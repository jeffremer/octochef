//
//  Blob.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Blob.h"
#import "ObjectMapperDelegate.h"
#import "UserSingleton.h"

@implementation Blob
@synthesize content;
@synthesize encoding;
-(void)writeBlobToFile:(ObjectMapperDelegate *)omDelegate {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * path = [[[[[paths objectAtIndex:0] stringByAppendingPathComponent:[UserSingleton sharedUser].username]
                       stringByAppendingPathComponent:omDelegate.currentRepository]
                       stringByAppendingPathComponent:omDelegate.currentBlob]
                       stringByAppendingString:@".blob"];
    NSError *error;
    [self.content writeToFile:path atomically:NO encoding:NSASCIIStringEncoding error:&error];
    if (error != NULL) {
        NSLog(@"Create file error: %@", error);
    }
        
}
@end
