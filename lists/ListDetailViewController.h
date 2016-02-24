//
//  ListDetailViewController.h
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *listAuthor;
@property (weak, nonatomic) IBOutlet UIButton *listSubscriberCountButton;
@property (weak, nonatomic) IBOutlet UITableView *itemsTableView;

@end
