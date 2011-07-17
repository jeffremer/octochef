//
//  UserSingleton.h
//  octochef
//
//  Created by Clay Smith on 7/17/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserSingleton : NSObject {
    NSString *_username;
}

@property (nonatomic, retain) NSString * username;
+ (UserSingleton *)sharedUser;
@end
