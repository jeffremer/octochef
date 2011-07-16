//
//  LoginViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDelegate.h"

@class RootViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    
}

- (IBAction)login:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) id <LoginDelegate> delegate;

@end
