//
//  MainViewController.m
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "Models.h"
#import "ObjectMapperDelegate.h"

@implementation MainViewController


@synthesize username;
@synthesize password;
@synthesize loggedIn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loggedIn = NO;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [username release];
    [password release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)presentLoginView {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    loginViewController.delegate = self;
    [self presentModalViewController:loginViewController animated:NO];
    
    [loginViewController release];            
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!self.loggedIn) {
        [self performSelector:@selector(presentLoginView) withObject:nil afterDelay:0];
    }
}

- (void)viewDidLoad
{    
    [super viewDidLoad];    
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

#pragma mark - LoginDelegate

- (void)userDidLogInWith:(NSString *)uname and:(NSString *)passwd {
    self.username = uname;
    self.password = passwd;
    self.loggedIn = YES;
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    // TODO: save repos by user name!
    NSString *filePath =  [libraryDirectory stringByAppendingPathComponent:@"Repositories.txt"];
    
    NSArray *repos = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (repos != nil) {
        NSLog(@"repos exist locally!");
    } else {
        ObjectMapperDelegate *omDelegate = [[ObjectMapperDelegate alloc] init];
        RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Repository class]];
        [mapping mapAttributes:@"description", @"name", @"created_at", @"html_url", nil];
        NSString *resource = [NSString stringWithFormat:@"/users/%@/repos", self.username]; 
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resource objectMapping:mapping  delegate:omDelegate];        
    }

    

}


@end
