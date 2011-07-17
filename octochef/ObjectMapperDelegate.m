//
//  ObjectMapperDelegate.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "ObjectMapperDelegate.h"


@implementation ObjectMapperDelegate
-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSLog(@"count of objects: %d", [objects count]);
    
    if ([objects count] > 0) {
        id firstClass = [[objects objectAtIndex:0] class];
        if (firstClass == [Repository class]) {
            for (id object in objects) {
                Repository* repo = object;
                NSLog(@"Loaded repository: %@", repo.name);
            }
        } else if (firstClass == [Branch class]) {
            for (id object in objects) {
                Branch* branch = object;
                NSLog(@"Loaded brach: %@: %@", branch.name, branch.sha);
            }
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
