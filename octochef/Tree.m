//
//  Tree.m
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "Models.h"

@implementation Tree
@synthesize tree;

-(void)getRecipiesFromTree{
    // TODO: filter out recipies from the tree
    for (id object in self.tree) {
        
        Leaf * leaf = object;
        // leaf.path <-- filter on this
        NSLog(@"leaf: %@", leaf.sha);
        //[leaf fetchBlobWithDelegate:<#(ObjectMapperDelegate *)#> andRepo:<#(NSString *)#> andSha:<#(NSString *)#>
    }
}
@end
