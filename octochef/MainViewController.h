//
//  MainViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "LoginDelegate.h"
@class RootViewController;

@interface MainViewController : UISplitViewController <LoginDelegate, RKObjectLoaderDelegate> {
    
}


- (void) finishedChoosing;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

@property BOOL loggedIn;

@property (nonatomic, retain) NSMutableArray *repositories;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end
