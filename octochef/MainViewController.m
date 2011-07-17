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
#import "RepositoryChooserViewController.h"
#import "UserSingleton.h"

@implementation MainViewController


@synthesize username;
@synthesize password;
@synthesize loggedIn;

@synthesize repositories;

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

-(void)presentRepositoryChooserView {
    RepositoryChooserViewController *repositoryChooserViewController = [[RepositoryChooserViewController alloc] initWithNibName:@"RepositoryChooserViewController" bundle:nil];
    repositoryChooserViewController.repositoriesArray = self.repositories;
    repositoryChooserViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentModalViewController:repositoryChooserViewController animated:YES];
    [repositoryChooserViewController release];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(!self.loggedIn) {
        [self performSelector:@selector(presentLoginView) withObject:nil afterDelay:0];
    } else if([self.repositories count] > 0) {
        [self performSelector:@selector(presentRepositoryChooserView) withObject:nil afterDelay:0];
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
    
    [UserSingleton sharedUser].username = self.username;

    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Repository class]];
    [mapping mapAttributes:@"description", @"name", @"created_at", @"html_url", nil];
    NSString *resource = [NSString stringWithFormat:@"/users/%@/repos", self.username]; 
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resource objectMapping:mapping  delegate:self];
}


-(void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {    
    if ([objects count] > 0 && [[objects objectAtIndex:0] class] == [Repository class]) {
        self.repositories = [objects mutableCopy];
        // Build directory tree of respositories
        [Repository buildDirectoryTree:objects];
    }
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"Trouble loading repositories %@", error);
}

@end
