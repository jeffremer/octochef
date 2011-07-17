//
//  Repository.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ObjectMapperDelegate;

@interface Repository : NSObject <NSCoding> {
    NSString * _name;
    NSString * _description;
    NSString * _created_at;
    NSString * _html_url;
}
-(void) fetchBranchesWithDelegate: (ObjectMapperDelegate*) omDelegate;
+(void) buildDirectoryTree: (NSArray *)repos;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * html_url;
@end
