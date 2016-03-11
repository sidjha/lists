//
//  ListTextItemTableViewCell.h
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTextItemTableViewCell : UITableViewCell <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *editableText;

@property (weak, nonatomic) IBOutlet UIButton *editableLocationButton;

@property (weak, nonatomic) IBOutlet UILabel *rowIndicatorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *editableImageView;


@end
