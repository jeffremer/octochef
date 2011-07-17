//
//  RepositoryChooserViewController.m
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import "RepositoryChooserViewController.h"
#import "Repository.h"
#include "ObjectMapperDelegate.h"

@implementation RepositoryChooserViewController
@synthesize repositoriesArray;
@synthesize tableView;
@synthesize topToolbar;
@synthesize delegate;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.repositoriesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Repository *repo = [self.repositoriesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = repo.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 3;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString * selectedRepo = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
//    ObjectMapperDelegate * omDelegate = [[ObjectMapperDelegate alloc] init];
//    omDelegate.currentRepository = selectedRepo;
//    [Repository fetchBranchesWithDelegate:omDelegate];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (IBAction) done:(id)sender {
    if([self.tableView respondsToSelector:@selector(indexPathsForSelectedRows)]) {
        NSArray *indexes = [self.tableView indexPathsForSelectedRows];                
        for (NSIndexPath *path in indexes) {
            Repository *repo = [repositoriesArray objectAtIndex:path.row];
            NSLog(@"Selected repo %@", repo.name);
            ObjectMapperDelegate *del = [[ObjectMapperDelegate alloc] init];
            del.currentRepository = repo.name;
            del.delegate = self;
            [Repository fetchBranchesWithDelegate:del];
            [Repository buildDirectoryTree: [NSArray arrayWithObject:repo]];
        }
        if([self.delegate respondsToSelector:@selector(finishedChoosing)]) {
            [self.delegate finishedChoosing];
        }
    }
}

- (void) didFinishDownloading {
    [self dismissModalViewControllerAnimated:YES];
}

@end
