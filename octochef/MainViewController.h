//
//  MainViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDelegate.h"

@interface MainViewController : UISplitViewController <LoginDelegate> {
    
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

@property BOOL loggedIn;

@end
