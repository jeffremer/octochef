//
//  ObjectMapperDelegate.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Models.h"

@interface ObjectMapperDelegate : NSObject <RKObjectLoaderDelegate> {
    NSString * _username;
    NSString * _currentRepo;
    NSString * _currentBranch;
    NSString * _currentBlob;
}

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * currentRepository;
@property (nonatomic, retain) NSString * currentBranch;
@property (nonatomic, retain) NSString * currentBlob;
@property (nonatomic, retain) id delegate;

@end
