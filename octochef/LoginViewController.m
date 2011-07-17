//
//  LoginViewController.m
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize usernameField = _usernameField;

@synthesize passwordField = _passwordField;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
//    self.view.backgroundColor = background;
//    [background release];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Actions

- (IBAction)login:(id)sender {    
    [RKClient clientWithBaseURL:@"https://api.github.com"];
    [RKObjectManager objectManagerWithBaseURL:@"https://api.github.com"];
    [RKClient sharedClient].forceBasicAuthentication = YES;
    [RKClient sharedClient].username = self.usernameField.text;
    [RKClient sharedClient].password = self.passwordField.text;

    [RKObjectManager sharedManager].client = [RKClient sharedClient];

    
    [[RKClient sharedClient] get:@"/user" delegate: self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.usernameField) {
        [textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    }

    BOOL shouldReturn = !([self.usernameField.text isEqualToString:@""] && [self.passwordField.text isEqualToString:@""]);

    if(shouldReturn) {
        [textField resignFirstResponder];
        [self login:self];
    }
    
    return shouldReturn;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

#pragma mark - RKRequestDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {  
    if([response isOK]) {
        if([self.delegate respondsToSelector:@selector(userDidLogInWith:and:)]) {
            [self.delegate userDidLogInWith: self.usernameField.text and: self.passwordField.text];
        }
        
        [self dismissModalViewControllerAnimated:YES];
    } else if ([response isJSON]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Problem Logging In"  
                                                          message:@"Sorry, there was trouble authenticating you, please try again."  
                                                         delegate:nil  
                                                cancelButtonTitle:@"OK"  
                                                otherButtonTitles:nil];  
        
        [message show];  
        
        [message release];         
        
        [self.usernameField becomeFirstResponder];
    }
}
@end
