//
//  ImagePickerViewController.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 11/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ImagePickerViewController : UIImagePickerController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong) NSString *cardName;

@end

