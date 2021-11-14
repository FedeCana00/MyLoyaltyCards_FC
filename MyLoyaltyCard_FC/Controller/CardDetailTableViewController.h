//
//  CardDetailTableViewController.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardDetailTableViewController : UITableViewController

@property(nonatomic, strong) Card *theCard;

@end

NS_ASSUME_NONNULL_END
