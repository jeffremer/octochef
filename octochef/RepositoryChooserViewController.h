//
//  RepositoryChooserViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RepositoryChooserViewController : UIViewController {
    
}

- (IBAction)done:(id)sender;
- (void) didFinishDownloading;

@property (nonatomic, retain) NSMutableArray *repositoriesArray;
@property (nonatomic, retain) IBOutlet UIToolbar *topToolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
