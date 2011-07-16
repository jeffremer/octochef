//
//  LoginDelegate.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LoginDelegate <NSObject>

-(void) userDidLogInWith: (NSString*) username and: (NSString*) password;

@end
