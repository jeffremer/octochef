//
//  Tree.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Models.h"
#import "ObjectMapperDelegate.h"

@implementation Tree
@synthesize tree;

-(void) getRecipies:(ObjectMapperDelegate *)omDelegate {
    // TODO: filter out recipies from the tree
    for (id object in self.tree) {
        Leaf * leaf = object;
        // leaf.path <-- filter on this
        NSLog(@"leaf: %@", leaf.sha);
        ObjectMapperDelegate * newDelegate = [[ObjectMapperDelegate alloc] init];
        newDelegate.currentRepository = omDelegate.currentRepository;
        newDelegate.currentBlob = leaf.sha;
        newDelegate.delegate = omDelegate.delegate;
        
        [Leaf fetchBlobWithDelegate:newDelegate];
        //[leaf fetchBlobWithDelegate:<#(ObjectMapperDelegate *)#> andRepo:<#(NSString *)#> andSha:<#(NSString *)#>
    }
}
@end
