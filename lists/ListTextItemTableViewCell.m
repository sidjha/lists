//
//  ListTextItemTableViewCell.m
//  lists
//
//  Created by Sid Jha on 2016-02-24.
//  Copyright © 2016 Mesh8. All rights reserved.
//

#import "ListTextItemTableViewCell.h"

@implementation ListTextItemTableViewCell

- (void)awakeFromNib {
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    
    self.editableImageView.userInteractionEnabled = YES;
    [self.editableImageView addGestureRecognizer:singleTap];
    
}

- (void) imageTapDetected {
    NSLog(@"Tap detected.");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
