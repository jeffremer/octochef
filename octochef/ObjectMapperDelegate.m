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

-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {    
    if ([objects count] > 0) {
        id firstClass = [[objects objectAtIndex:0] class];
        if (firstClass == [Repository class]) {
            for (id object in objects) {
                Repository* repo = object;
                NSLog(@"Loaded repository from server: %@", repo.name);
                [repo fetchBranchesWithDelegate:self];
            }
        } else if (firstClass == [Branch class]) {
            Branch* branch = [objects objectAtIndex:0];
            NSLog(@"Loaded branch: %@: %@", branch.name, branch.sha);
            [branch fetchTreeWithDelegate:self]; 
        } else if (firstClass == [Tree class]) {
            for (id object in objects) {
                Tree* tree = object;
                NSLog(@"leaves: %d", [tree.tree count]);
            }
        } else if (firstClass == [Blob class]) {
            for (id object in objects) {
                //Blob* blob = object;
                //NSData * data = [NSData base64DataFromString: blob.content];
                //NSString *someString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                
                //NSLog(@"blob encoding: %@", someString);
            }
        }
    }
}

-(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
}
@end
