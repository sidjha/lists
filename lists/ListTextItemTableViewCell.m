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
    
    // Configure image tapping
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    
    self.editableImageView.userInteractionEnabled = YES;
    [self.editableImageView addGestureRecognizer:singleTap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) imageTapDetected {
    // Get the underlying controller so you can present the alert dialog
    UIViewController *activeVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    // configure image picker
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self; // seems like this is okay
    imgPicker.allowsEditing = YES;
    
    // configure action sheer
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    /*
     // for taking a photo
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
     
     [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     
     imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
     imgPicker.modalPresentationStyle = UIModalPresentationPopover;
     imgPicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
     
     [activeVC presentViewController:imgPicker animated:YES completion:nil];
     
     }]];
     } */
    
    // for uploading
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Upload Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.modalPresentationStyle = UIModalPresentationPopover;
        
        [activeVC presentViewController:imgPicker animated:YES completion:nil];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [activeVC presentViewController:actionSheet animated:YES completion:nil];
    
}


#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.editableImageView.image = chosenImage;
    self.editableImageView.clipsToBounds = YES;
    
    NSData *imgData = UIImageJPEGRepresentation(chosenImage, 0.9);
    
    // TODO: upload the image to server
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
