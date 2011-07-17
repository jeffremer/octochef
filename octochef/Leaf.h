//
//  Tree.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ObjectMapperDelegate;

@interface Leaf : NSObject {
    NSString * _path;
    NSString * _sha;
    NSUInteger _size;
}
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * sha;
@property (nonatomic) NSUInteger  size;
-(void) fetchBlobWithDelegate:(ObjectMapperDelegate*) omDelegate andRepo:(NSString *) repo;

@end
