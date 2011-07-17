//
//  RootViewController.h
//  octochef
//
//  Created by Jeff Remer on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    NSMutableArray *recipesArray;
}

		
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
