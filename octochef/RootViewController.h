//
//  RootViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDelegate.h"

@class DetailViewController;

@interface RootViewController : UITableViewController <LoginDelegate> {

}

		
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

@property BOOL loggedIn;

@end
