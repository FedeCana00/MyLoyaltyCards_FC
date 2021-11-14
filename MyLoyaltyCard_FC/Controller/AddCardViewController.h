//
//  AddCardViewController.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 07/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCardViewController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

//indica che numero di carta sto inserendo
@property(nonatomic)long numberOfCard;

@end


