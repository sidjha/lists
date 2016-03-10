//
//  ListDetailViewController.h
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListDetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (retain) NSMutableArray *listItems;

@end
