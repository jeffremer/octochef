//
//  ObjectMapperDelegate.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "ObjectMapperDelegate.h"

@implementation ObjectMapperDelegate

@synthesize username;
@synthesize currentRepository;
@synthesize currentBranch;
@synthesize currentBlob;
@synthesize delegate;

-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {    
    if ([objects count] > 0) {
        id firstClass = [[objects objectAtIndex:0] class];
        if (firstClass == [Branch class]) {
            Branch* branch = [objects objectAtIndex:0];
            
            ObjectMapperDelegate * omd = [[ObjectMapperDelegate alloc] init];
            omd.currentRepository = self.currentRepository;
            omd.currentBranch = branch.sha;
            omd.delegate = self.delegate;
            
            NSLog(@"Loaded branch: %@: %@", branch.name, branch.sha);
            [Branch fetchTreeWithDelegate:omd];
        } else if (firstClass == [Tree class]) {
            for (id object in objects) {
                Tree* tree = object;
                NSLog(@"leaves: %d", [tree.tree count]);
                [tree getRecipies:self];
            }
        } else if (firstClass == [Blob class]) {
            for (id object in objects) {
                Blob* blob = object;
                //NSData * data = [NSData base64DataFromString: blob.content];
                //NSString *someString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                
                NSLog(@"blob encoding: %@", blob.encoding);
            }
            if([self.delegate respondsToSelector:@selector(didFinishDownloading)]) {
                [self.delegate didFinishDownloading];
            }
        }
    }
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
}
@end
