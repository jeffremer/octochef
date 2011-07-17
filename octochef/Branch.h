//
//  Branch.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Branch : NSObject {
    NSString * _name;
    NSString * _sha;
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sha;

@end
