//
//  ListTableViewCell.h
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscriberCountLabel;


@end
